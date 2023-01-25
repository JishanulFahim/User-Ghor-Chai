// ignore_for_file: deprecated_member_use

import 'package:demo/utils/custom_color.dart';
import 'package:demo/utils/dimensions.dart';
import 'package:demo/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/dark_theme_provider.dart';
import '../../widgets/appbar/custom_app_bar.dart';

class InfoScreen extends StatefulWidget {
  final String title;
  const InfoScreen({super.key, required this.title});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        widget.title,
        bgClr: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 0.6),
        child: ListView(
          children: [
            addVerticalSpace(Dimensions.heightSize * 5),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.largeTextSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            addVerticalSpace(Dimensions.heightSize * 2),
            Visibility(
              visible: widget.title == 'Contact Us',
              child: Column(
                children: [
                  const Text(
                    textAlign: TextAlign.justify,
                    '''Please send your feedback, comments, and requests for technical support by
\n''',
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        launch('mailto:ghor.chai191@gmail.com ');
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue,
                      ),
                      child: Row(
                        mainAxisAlignment: mainCenter,
                        children: [
                          const Text(
                            'Contact By Email',
                            style: TextStyle(color: Colors.white),
                          ),
                          addHorizontalSpace(Dimensions.widthSize),
                          const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  addVerticalSpace(Dimensions.heightSize * 2),
                ],
              ),
            ),
            Visibility(
              visible: widget.title == 'Membership',
              child: Column(
                children: [
                  const Text(
                    textAlign: TextAlign.justify,
'''If you want to take your post on high on top, then you have to take membership\n
after paying 500 taka\n
For purchasing\n
''',
                  ),
                  const Text(
                    'Contact by Call or Email',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  addVerticalSpace(Dimensions.heightSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            launch('tel:01856199643');
                          });
                        },
                        child: Container(
                          height: 45,
                          width: 145,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blue,
                          ),
                          child: const Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            launch('mailto:ghor.chai191@gmail.com');
                          });
                        },
                        child: Container(
                          height: 45,
                          width: 145,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blue,
                          ),
                          child: const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: widget.title == 'About Us',
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  const Text(
                    textAlign: TextAlign.justify,
                    '''Our home sales and rental application is designed to make the process of buying or renting a home easier and more convenient. With our platform, users can search for homes in their zzdesired location and view listings with detailed information and photos. They can also connect with real estate agents and property owners to schedule viewings and ask questions.\n\nOne of the key features of our application is the ability to filter search results based on various criteria, such as price, number of bedrooms and bathrooms, square footage, and more. This allows users to find homes that meet their specific needs and preferences.\n\nIn addition to searching for homes, our application also provides tools for users to track their favorite listings and save them for later. They can also set up alerts to be notified when new listings that match their search criteria become available.\n\nOur team is dedicated to providing a seamless and user-friendly experience for those looking to buy or rent a home. We hope that our application helps make the process of finding a new home as stress-free and enjoyable as possible.''',
                  ),
                  addVerticalSpace(Dimensions.heightSize),
                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: const [
                      Text(
                        'Find House',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Check',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Enjoy',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Visibility(
              visible: widget.title == 'Terms & Policies',
              child: const Text(
                textAlign: TextAlign.justify,
                '''1. Introduction
Welcome to Ghor Chai (“Company”, “we”, “our”, “us”)!
These Terms of Service (“Terms”, “Terms of Service”) govern your use of our website
located at www.ghorchai.com (together or individually “Service”) operated by House
Rent.
Our Privacy Policy also governs your use of our Service and explains how we collect,
safeguard and disclose information that results from your use of our web pages.\n\nYour agreement with us includes these Terms and our Privacy Policy (“Agreements”).
You acknowledge that you have read and understood Agreements, and agree to be
bound of them.\n\nIf you do not agree with (or cannot comply with) Agreements, then you may not use the
Service, but please let us know by emailing at ghor.chai191@gmail.com so we can try to
find a solution. These Terms apply to all visitors, users and others who wish to access or
use Service.\n\n2. Communications
By using our Service, you agree to subscribe to newsletters, marketing or promotional
materials and other information we may send. However, you may opt out of receiving
any, or all, of these communications from us by following the unsubscribe link or by
emailing at ghor.chai191@gmail.com.\n\n3. Purchases
If you wish to purchase any product or service made available through Service
(“Purchase”), you may be asked to supply certain information relevant to your Purchase
including but not limited to, your credit or debit card number, the expiration date of
your card, your billing address, and your shipping information.\n\nYou represent and warrant that: (i) you have the legal right to use any card(s) or other
payment method(s) in connection with any Purchase; and that (ii) the information you
supply to us is true, correct and complete.\n\nWe may employ the use of third party services for the purpose of facilitating payment
and the completion of Purchases. By submitting your information, you grant us the right
to provide the information to these third parties subject to our Privacy Policy.\n\nWe reserve the right to refuse or cancel your order at any time for reasons including but
not limited to: product or service availability, errors in the description or price of the
product or service, error in your order or other reasons.
We reserve the right to refuse or cancel your order if fraud or an unauthorized or illegal
transaction is suspected.\n\n4. Contests, Sweepstakes and Promotions
Any contests, sweepstakes or other promotions (collectively, “Promotions”) made
available through Service may be governed by rules that are separate from these Terms
of Service. If you participate in any Promotions, please review the applicable rules as
well as our Privacy Policy. If the rules for a Promotion conflict with these Terms of
Service, Promotion rules will apply.\n\n5. Subscriptions
Some parts of Service are billed on a subscription basis ("Subscription(s)"). You will be
billed in advance on a recurring and periodic basis ("Billing Cycle"). Billing cycles will be
set depending on the type of subscription plan you select when purchasing a
Subscription.\n\nAt the end of each Billing Cycle, your Subscription will automatically renew under the
exact same conditions unless you cancel it or House Rent cancels it. You may cancel your
Subscription renewal either through your online account management page or by
contacting ghor.chai191@gmail.com customer support team.
A valid payment method is required to process the payment for your subscription. You
shall provide House Rent with accurate and complete billing information that may
include but not limited to full name, address, state, postal or zip code, telephone
number, and a valid payment method information. By submitting such payment
information, you automatically authorize House Rent to charge all Subscription fees
incurred through your account to any such payment instruments.
Should automatic billing fail to occur for any reason, House Rent reserves the right to
terminate your access to the Service with immediate effect.\n\n6. Free Trial
House Rent may, at its sole discretion, offer a Subscription with a free trial for a limited
period of time ("Free Trial").
You may be required to enter your billing information in order to sign up for Free Trial.\n\nIf you do enter your billing information when signing up for Free Trial, you will not be
charged by House Rent until Free Trial has expired. On the last day of Free Trial period,\n\nunless you cancelled your Subscription, you will be automatically charged the applicable
Subscription fees for the type of Subscription you have selected.
At any time and without notice, House Rent reserves the right to (i) modify Terms of
Service of Free Trial offer, or (ii) cancel such Free Trial offer.\n\n7. Fee Changes
House Rent, in its sole discretion and at any time, may modify Subscription fees for the
Subscriptions. Any Subscription fee change will become effective at the end of the then-
current Billing Cycle.
House Rent will provide you with a reasonable prior notice of any change in Subscription
fees to give you an opportunity to terminate your Subscription before such change
becomes effective.
Your continued use of Service after Subscription fee change comes into effect
constitutes your agreement to pay the modified Subscription fee amount.\n\n8. Refunds
We issue refunds for Contracts within 7 days of the original purchase of the Contract.\n\n9. Content
Content found on or through this Service are the property of House Rent or used with
permission. You may not distribute, modify, transmit, reuse, download, repost, copy, or
use said Content, whether in whole or in part, for commercial\n\n10. Prohibited Uses
You may use Service only for lawful purposes and in accordance with Terms. You agree
not to use Service:\n\n0.1. In any way that violates any applicable national or international law or regulation.
\n\n0.2. For the purpose of exploiting, harming, or attempting to exploit or harm minors in
any way by exposing them to inappropriate content or otherwise.
\n\n0.3. To transmit, or procure the sending of, any advertising or promotional material,
including any “junk mail”, “chain letter,” “spam,” or any other similar solicitation.
\n\n0.4. To impersonate or attempt to impersonate Company, a Company employee,
another user, or any other person or entity.
\n\n0.5. In any way that infringes upon the rights of others, or in any way is illegal,
threatening, fraudulent, or harmful, or in connection with any unlawful, illegal,
fraudulent, or harmful purpose or activity.\n\n0.6. To engage in any other conduct that restricts or inhibits anyone’s use or enjoyment
of Service, or which, as determined by us, may harm or offend Company or users of
Service or expose them to liability.\n\n0.1. Use Service in any manner that could disable, overburden, damage, or impair
Service or interfere with any other party’s use of Service, including their ability to
engage in real time activities through Service.
\n\n0.2. Use any robot, spider, or other automatic device, process, or means to access
Service for any purpose, including monitoring or copying any of the material on Service.
\n\n0.3. Use any manual process to monitor or copy any of the material on Service or for any
other unauthorized purpose without our prior written consent.
\n\n0.4. Use any device, software, or routine that interferes with the proper working of
Service.
\n\n0.5. Introduce any viruses, Trojan horses, worms, logic bombs, or other material which is
malicious or technologically harmful.
\n\n0.6. Attempt to gain unauthorized access to, interfere with, damage, or disrupt any
parts of Service, the server on which Service is stored, or any server, computer, or
database connected to Service.
\n\n0.7. Attack Service via a denial-of-service attack or a distributed denial-of-service attack.
\n\n0.8. Take any acti\n\non that may damage or falsify Company rating.
\n\n0.9. Otherwise attempt to interfere with the proper working of Service.\n\n11. Analytics
We may use third-party Service Providers to monitor and analyze the use of our Service.
\n\n12. No Use by Minors
Service is intended only for access and use by individuals at least eighteen (18) years
old. By accessing or using Service, you warrant and represent that you are at least
eighteen (18) years of age and with the full authority, right, and capacity to enter intothis agreement and abide by all of the terms and conditions of Terms. If you are not at
least eighteen (18) years old, you are prohibited from both the access and usage of
Service.
\n\n13. Accounts
When you create an account with us, you guarantee that you are above the age of 18,
and that the information you provide us is accurate, complete, and current at all times.
Inaccurate, incomplete, or obsolete information may result in the immediate
termination of your account on Service.
You are responsible for maintaining the confidentiality of your account and password,
including but not limited to the restriction of access to your computer and/or account.
You agree to accept responsibility for any and all activities or actions that occur under
your account and/or password, whether your password is with our Service or a third-
party service. You must notify us immediately upon becoming aware of any breach of
security or unauthorized use of your account.
You may not use as a username the name of another person or entity or that is not
lawfully available for use, a name or trademark that is subject to any rights of another
person or entity other than you, without appropriate authorization. You may not use as
a username any name that is offensive, vulgar or obscene.
We reserve the right to refuse service, terminate accounts, remove or edit content, or
cancel orders in our sole discretion.
\n\n14. Intellectual Property
Service and its original content (excluding Content provided by users), features and
functionality are and will remain the exclusive property of House Rent and its licensors.
Service is protected by copyright, trademark, and other laws of and foreign countries.
Our trademarks may not be used in connection with any product or service without the
prior written consent of House Rent.
\n\n15. Copyright Policy
We respect the intellectual property rights of others. It is our policy to respond to any
claim that Content posted on Service infringes on the copyright or other intellectual
property rights (“Infringement”) of any person or entity.
If you are a copyright owner, or authorized on behalf of one, and you believe that the
copyrighted work has been copied in a way that constitutes copyright infringement,
please submit your claim via email to ghor.chai191@gmail.com, with the subject line:
“Copyright Infringement” and include in your claim a detailed description of the allegedInfringement as detailed below, under “DMCA Notice and Procedure for Copyright
Infringement Claims”
You may be held accountable for damages (including costs and attorneys’ fees) for
misrepresentation or bad-faith claims on the infringement of any Content found on
and/or through Service on your copyright.
\n\n16. DMCA Notice and Procedure for Copyright Infringement Claims
You may submit a notification pursuant to the Digital Millennium Copyright Act (DMCA)
by providing our Copyright Agent with the following information in writing (see 17 U.S.C
512(c)(3) for further detail):\n\n0.1. an electronic or physical signature of the person authorized to act on behalf of the
owner of the copyright’s interest;
\n\n0.2. a description of the copyrighted work that you claim has been infringed, including
the URL (i.e., web page address) of the location where the copyrighted work exists or a
copy of the copyrighted work;
\n\n0.3. identification of the URL or other specific location on Service where the material
that you claim is infringing is located;
\n\n0.4. your address, telephone number, and email address;
\n\n0.5. a statement by you that you have a good faith belief that the disputed use is not
authorized by the copyright owner, its agent, or the law;
\n\n0.6. a statement by you, made under penalty of perjury, that the above information in
your notice is accurate and that you are the copyright owner or authorized to act on the
copyright owner’s behalf.\n\n17. Error Reporting and Feedback
You may provide us either directly at ghor.chai191@gmail.com or via third party sites
and tools with information and feedback concerning errors, suggestions for
improvements, ideas, problems, complaints, and other matters related to our Service
(“Feedback”). You acknowledge and agree that: (i) you shall not retain, acquire or assert
any intellectual property right or other right, title or interest in or to the Feedback; (ii)
Company may have development ideas similar to the Feedback; (iii) Feedback does not
contain confidential information or proprietary information from you or any third party;and (iv) Company is not under any obligation of confidentiality with respect to the
Feedback. In the event the transfer of the ownership to the Feedback is not possible due
to applicable mandatory laws, you grant Company and its affiliates an exclusive,
transferable, irrevocable, free-of-charge, sub-licensable, unlimited and perpetual right
to use (including copy, modify, create derivative works, publish, distribute and
commercialize) Feedback in any manner and for any purpose.\n\n18. Links To Other Web Sites
Our Service may contain links to third party web sites or services that are not owned or
controlled by House Rent.
House Rent has no control over, and assumes no responsibility for the content, privacy
policies, or practices of any third party web sites or services. We do not warrant the
offerings of any of these entities/individuals or their websites.
For example, the outlined Terms of Use have been created using PolicyMaker.io, a free
web application for generating high-quality legal documents. Policymaker’s Terms and
Conditions generator is an easy-to-use free tool for creating an excellent standard Terms
of Service template for a website, blog, e-commerce store or app.
YOU ACKNOWLEDGE AND AGREE THAT COMPANY SHALL NOT BE RESPONSIBLE OR
LIABLE, DIRECTLY OR INDIRECTLY, FOR ANY DAMAGE OR LOSS CAUSED OR ALLEGED TO
BE CAUSED BY OR IN CONNECTION WITH USE OF OR RELIANCE ON ANY SUCH CONTENT,
GOODS OR SERVICES AVAILABLE ON OR THROUGH ANY SUCH THIRD PARTY WEB SITES
OR SERVICES.
WE STRONGLY ADVISE YOU TO READ THE TERMS OF SERVICE AND PRIVACY POLICIES OF
ANY THIRD PARTY WEB SITES OR SERVICES THAT YOU VISIT.\n\n19. Disclaimer Of Warranty
THESE SERVICES ARE PROVIDED BY COMPANY ON AN “AS IS” AND “AS AVAILABLE”
BASIS. COMPANY MAKES NO REPRESENTATIONS OR WARRANTIES OF ANY KIND,
EXPRESS OR IMPLIED, AS TO THE OPERATION OF THEIR SERVICES, OR THE
INFORMATION, CONTENT OR MATERIALS INCLUDED THEREIN. YOU EXPRESSLY AGREE
THAT YOUR USE OF THESE SERVICES, THEIR CONTENT, AND ANY SERVICES OR ITEMS
OBTAINED FROM US IS AT YOUR SOLE RISK.
NEITHER COMPANY NOR ANY PERSON ASSOCIATED WITH COMPANY MAKES ANY
WARRANTY OR REPRESENTATION WITH RESPECT TO THE COMPLETENESS, SECURITY,
RELIABILITY, QUALITY, ACCURACY, OR AVAILABILITY OF THE SERVICES. WITHOUT
LIMITING THE FOREGOING, NEITHER COMPANY NOR ANYONE ASSOCIATED WITH
COMPANY REPRESENTS OR WARRANTS THAT THE SERVICES, THEIR CONTENT, OR ANY
SERVICES OR ITEMS OBTAINED THROUGH THE SERVICES WILL BE ACCURATE, RELIABLE,
ERROR-FREE, OR UNINTERRUPTED, THAT DEFECTS WILL BE CORRECTED, THAT THESERVICES OR THE SERVER THAT MAKES IT AVAILABLE ARE FREE OF VIRUSES OR OTHER
HARMFUL COMPONENTS OR THAT THE SERVICES OR ANY SERVICES OR ITEMS
OBTAINED THROUGH THE SERVICES WILL OTHERWISE MEET YOUR NEEDS OR
EXPECTATIONS.
COMPANY HEREBY DISCLAIMS ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR
IMPLIED, STATUTORY, OR OTHERWISE, INCLUDING BUT NOT LIMITED TO ANY
WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, AND FITNESS FOR
PARTICULAR PURPOSE.
THE FOREGOING DOES NOT AFFECT ANY WARRANTIES WHICH CANNOT BE EXCLUDED
OR LIMITED UNDER APPLICABLE LAW.\n\n20. Limitation Of Liability
EXCEPT AS PROHIBITED BY LAW, YOU WILL HOLD US AND OUR OFFICERS, DIRECTORS,
EMPLOYEES, AND AGENTS HARMLESS FOR ANY INDIRECT, PUNITIVE, SPECIAL,
INCIDENTAL, OR CONSEQUENTIAL DAMAGE, HOWEVER IT ARISES (INCLUDING
ATTORNEYS’ FEES AND ALL RELATED COSTS AND EXPENSES OF LITIGATION AND
ARBITRATION, OR AT TRIAL OR ON APPEAL, IF ANY, WHETHER OR NOT LITIGATION OR
ARBITRATION IS INSTITUTED), WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE, OR
OTHER TORTIOUS ACTION, OR ARISING OUT OF OR IN CONNECTION WITH THIS
AGREEMENT, INCLUDING WITHOUT LIMITATION ANY CLAIM FOR PERSONAL INJURY OR
PROPERTY DAMAGE, ARISING FROM THIS AGREEMENT AND ANY VIOLATION BY YOU OF
ANY FEDERAL, STATE, OR LOCAL LAWS, STATUTES, RULES, OR REGULATIONS, EVEN IF
COMPANY HAS BEEN PREVIOUSLY ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
EXCEPT AS PROHIBITED BY LAW, IF THERE IS LIABILITY FOUND ON THE PART OF
COMPANY, IT WILL BE LIMITED TO THE AMOUNT PAID FOR THE PRODUCTS AND/OR
SERVICES, AND UNDER NO CIRCUMSTANCES WILL THERE BE CONSEQUENTIAL OR
PUNITIVE DAMAGES. SOME STATES DO NOT ALLOW THE EXCLUSION OR LIMITATION OF
PUNITIVE, INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THE PRIOR LIMITATION OR
EXCLUSION MAY NOT APPLY TO YOU.\n\n21. Termination
We may terminate or suspend your account and bar access to Service immediately,
without prior notice or liability, under our sole discretion, for any reason whatsoever
and without limitation, including but not limited to a breach of Terms.
If you wish to terminate your account, you may simply discontinue using Service.\n\n22. Governing Law
These Terms shall be governed and construed in accordance with the laws
of Bangladesh, which governing law applies to agreement without regard to its conflict
of law provisions.
Our failure to enforce any right or provision of these Terms will not be considered a
waiver of those rights. If any provision of these Terms is held to be invalid or
unenforceable by a court, the remaining provisions of these Terms will remain in effect.
These Terms constitute the entire agreement between us regarding our Service and
supersede and replace any prior agreements we might have had between us regarding
Service.\n\n23. Changes To Service
We reserve the right to withdraw or amend our Service, and any service or material we
provide via Service, in our sole discretion without notice. We will not be liable if for any
reason all or any part of Service is unavailable at any time or for any period. From time
to time, we may restrict access to some parts of Service, or the entire Service, to users,
including registered users.\n\n24. Amendments to Terms
We may amend Terms at any time by posting the amended terms on this site. It is your
responsibility to review these Terms periodically.\n\n
Your continued use of the Platform following the posting of revised Terms means that
you accept and agree to the changes. You are expected to check this page frequently so
you are aware of any changes, as they are binding on you.\n\n
By continuing to access or use our Service after any revisions become effective, you
agree to be bound by the revised terms. If you do not agree to the new terms, you are
no longer authorized to use Service.
\n\n25. Waiver and Severability
No waiver by Company of any term or condition set forth in Terms shall be deemed a
further or continuing waiver of such term or condition or a waiver of any other term or
condition, and any failure of Company to assert a right or provision under Terms shall
not constitute a waiver of such right or provision.\n\nIf any provision of Terms is held by a court or other tribunal of competent jurisdiction to
be invalid, illegal or unenforceable for any reason, such provision shall be eliminated or
limited to the minimum extent such that the remaining provisions of Terms will
continue in full force and effect.\n\n
26. Acknowledgement
BY USING SERVICE OR OTHER SERVICES PROVIDED BY US, YOU ACKNOWLEDGE THAT
YOU HAVE READ THESE TERMS OF SERVICE AND AGREE TO BE BOUND BY THEM.''',
              ),
            ),
            addVerticalSpace(Dimensions.heightSize),
          ],
        ),
      ),
    );
  }
}

class Electrician extends StatelessWidget {
  final String title;
  final List<String> list;
  const Electrician({super.key, required this.title, required this.list});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    bool isDark = themeState.getDarkTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title,
        bgClr: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.marginSize * 0.6,
          vertical: Dimensions.marginSize * 0.6,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: List.generate(
            list.length,
            (index) => Container(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.marginSize,
                horizontal: Dimensions.marginSize,
              ),
              margin: EdgeInsets.symmetric(
                vertical: Dimensions.marginSize * 0.4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius * 2),
                color:
                    isDark ? const Color(0xFF0a0d2c) : CustomColor.primaryColor,
              ),
              child: Text(
                textAlign: TextAlign.justify,
                list[index],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.extraSmallTextSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
