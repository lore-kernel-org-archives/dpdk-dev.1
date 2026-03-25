Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B202FEA830
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 08:17:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 663924028F;
	Wed, 25 Mar 2026 09:17:43 +0100 (CET)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 0336C4028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 09:17:41 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 70A1CEC024A;
 Wed, 25 Mar 2026 04:17:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 25 Mar 2026 04:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774426661;
 x=1774513061; bh=GmMMKNbAmMhaS6G+zw9JwUH39M5ELsMItzOAroxmwIY=; b=
 h1p1ayeJyZIDM5W5ocum0ERgNRtzvlYTdWQkrzvllOk8ChxYtkSUsfkQn9U/g61F
 96QDQUwBSz29negV2UIkqqsv2apKYIvpq16Son0Q9eXYwURWVg7QKm/ox9t6F46D
 bD/5PIx1pzn4utpwQXHsOEg4mrL3jOBoeeM5SAfcnrg6taiLbzH18MSwHZP/EjRc
 zV4EvuuvYttkJ3+/BYllbZuijNqdfOOl0/UqU6DRpAAHA9bFfQjbRY79SiVI/+fu
 CmDCzIkUYo7ddnb3bWJDq3CDEu/HXXjBK3WXazhzJdvH7vB5S+CNDxCBmWUeJ9ud
 ylmC9KeYQ8cV8YB9mQkRHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774426661; x=
 1774513061; bh=GmMMKNbAmMhaS6G+zw9JwUH39M5ELsMItzOAroxmwIY=; b=I
 JGemlAL46ZMM2S8A9kY+JWzle4yZgwRdoy0ZR3WWd36VF4jcwqVqTD0QGBDyGrTO
 ir8IzNpuRtpwuHsQCebh+SaXuOdQ9O2njUAlmVT07eVPYVjLBxnqqyB8muu9fy4v
 pQ59kuNSQtZBggWxbcr/D39LRD9CaFLrMPiNbxGaHZOFk1Yl+zTDbV2slhfMVgqE
 Ncky38eh46I76kLLbUEsy92znNZWddMO1ij0+76JLVcwPU9y3km1xVbgkB2VV04E
 Xo1MT8UQFjuqlOzEjdUvhufma/QPZnOKAbodFzudpsDb1VPzn3stA4SUaboTRJTp
 HjKn2O5x+l+WqrXYJ50DQ==
X-ME-Sender: <xms:JJrDafnvwioF8QOTNEN8y4ocnIkVjSmgEB0dpSX9Ww36dJv2-_5KjA>
 <xme:JJrDafKspy3FGTyBy4QAMSI4qFuiPSWBj__jrppe52MSXmL4N_n8G_X2Qo68VzGhf
 EoK63FhqRNF5sO_Wo3M8yySetYGZdAEZefddkO7Za0Wj0M9qL3W>
X-ME-Received: <xmr:JJrDaXSx0xrj-ugCaQKRjI9BTnWOD4c7iZXsALS21Z9WzwPtEIcbmetaVnZca3JerBcECeKqTxvxIiVM7Ol0YV5RoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefleeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedukedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgvvghmrgdrshhhrghrmhgrsehrrg
 guihhshihsrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepghgrkhhhihhlsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepuggrvhhiugdrmh
 grrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehn
 vghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopegrnhgrthholhihrdgsuh
 hrrghkohhvsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhgrtghkrdgsohhnugdqphhr
 vghsthhonhesfhhoshhsrdgrrhhmrdgtohhmpdhrtghpthhtohepfhgrnhiihhgrnhhgrd
 hoshhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrihdrjhhisehinhhtvghlrdgt
 ohhm
X-ME-Proxy: <xmx:JJrDaUuFxRWixSm0FH7vPFt-8SPdGKHzlC0ythQtmG2z2axzHlp_pA>
 <xmx:JJrDaS-_4GhAgE5eUZR-W8abNR0OF2R-G8zi9K6nzmLcijZbIejsSQ>
 <xmx:JJrDadZ5b7f3yDq2lzgaD9HvI071IPQpRz73_CY3mGJ4N4siW_Tk5A>
 <xmx:JJrDaerW9DOTkA2e9BF-CqewkCgMDMZum6iIbKVMInCXNU6O_6yWKA>
 <xmx:JZrDaZBtaeLTT7euC3cPfzemP6pw-QfCGqGLfxsreJ9azlJ9NV2ng1gW>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 04:17:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Reema Sharma <Reema.Sharma@radisys.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "gakhil@marvell.com" <gakhil@marvell.com>, 
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
 "jack.bond-preston@foss.arm.com" <jack.bond-preston@foss.arm.com>,
 "gakhil@marvell.com" <gakhil@marvell.com>,
 "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>,
 "kai.ji@intel.com" <kai.ji@intel.com>,
 Prakash Durgapal <Prakash.Durgapal@radisys.com>,
 Pratap Rana <Pratap.Rana@radisys.com>,
 Vijay Kumar Mahto <Vijay.Mahto@radisys.com>,
 Jaydipkumar Dhameliya <Jaydipkumar.Dhameliya@radisys.com>,
 "Liu1, Kai" <kai.liu1@intel.com>, "Zhang, Liheng" <liheng.zhang@intel.com>,
 "Xiong, Tanghong" <tanghong.xiong@intel.com>,
 Mattias =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>
Subject: Re: Request for Review of Fixes Applied for DPDK 24.11 and 25.11
 Compilation Errors
Date: Wed, 25 Mar 2026 09:17:36 +0100
Message-ID: <5559422.aeNJFYEL58@thomas>
In-Reply-To: <DS0PR08MB9465E1596F77A744A34FECD68649A@DS0PR08MB9465.namprd08.prod.outlook.com>
References: <DS0PR08MB946583905393503122A46A898663A@DS0PR08MB9465.namprd08.prod.outlook.com>
 <SA2PR11MB5051B9440668583D5524F40E847AA@SA2PR11MB5051.namprd11.prod.outlook.com>
 <DS0PR08MB9465E1596F77A744A34FECD68649A@DS0PR08MB9465.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Hello,

If I understand well, you hit 2 issues while compiling a C++ app linked wit=
h DPDK?
Could you share the exact version of your compiler?

=46or rte_bitops.h, if disabling these macros is OK for you, go with it for=
 now.
We will need to understand what happens exactly with __RTE_BIT_OVERLOAD mac=
ros.

=46or rte_cryptodev.h, it may be hiding an issue somewhere else.
Please could you share the exact error message?



25/03/2026 07:55, Reema Sharma:
> Hi Team,
>=20
> Could you please review the attached DPDK patch (dpdk-24.11_patch_for_cry=
pto.patch) and confirm whether the applied fixes are acceptable from the DP=
DK perspective?
> Your guidance on the correct fix, if any changes are needed, would help u=
s proceed with CU compilation.
> Kindly share an update at your earliest convenience.
> Thanks & Regards,
> Reema Sharma
> ________________________________
> From: Xiong, Tanghong <tanghong.xiong@intel.com>
> Sent: Friday, March 6, 2026 3:26 PM
> To: Zhang, Liheng <liheng.zhang@intel.com>; Reema Sharma <Reema.Sharma@ra=
disys.com>; Liu1, Kai <kai.liu1@intel.com>
> Cc: Prakash Durgapal <Prakash.Durgapal@radisys.com>; Pratap Rana <Pratap.=
Rana@radisys.com>; Vijay Kumar Mahto <Vijay.Mahto@radisys.com>; Jaydipkumar=
 Dhameliya <Jaydipkumar.Dhameliya@radisys.com>
> Subject: RE: Request for Review of Fixes Applied for DPDK 24.11 and 25.11=
 Compilation Errors
>=20
>=20
> Thanks Liheng,
>=20
> Just got other info that, you can contact  DPDK directly through this mai=
l: dev@dpdk.org<mailto:dev@dpdk.org>, but the response may be slow.
>=20
>=20
>=20
> BRs,
>=20
> Tanghong
>=20
>=20
>=20
> From: Zhang, Liheng <liheng.zhang@intel.com>
> Sent: Friday, March 6, 2026 5:51 PM
> To: Reema Sharma <Reema.Sharma@radisys.com>; Xiong, Tanghong <tanghong.xi=
ong@intel.com>; Liu1, Kai <kai.liu1@intel.com>
> Cc: Durgapal, Prakash <prakash.durgapal@radisys.com>; Pratap Rana <Pratap=
=2ERana@radisys.com>; Vijay Kumar Mahto <Vijay.Mahto@radisys.com>; Jaydipku=
mar Dhameliya <Jaydipkumar.Dhameliya@radisys.com>
> Subject: RE: Request for Review of Fixes Applied for DPDK 24.11 and 25.11=
 Compilation Errors
>=20
>=20
>=20
> Yes, there is a file =E2=80=9CMAINTAINERS=E2=80=9D in the DPDK root path.
>=20
> The file list all the contactor for all dpdk libraries.
>=20
> You can search and contact the person for crypto issue.
>=20
> If you can=E2=80=99t find it, please let me know, I can forward to you.
>=20
>=20
>=20
> From: Reema Sharma <Reema.Sharma@radisys.com<mailto:Reema.Sharma@radisys.=
com>>
> Sent: Friday, March 6, 2026 5:45 PM
> To: Zhang, Liheng <liheng.zhang@intel.com<mailto:liheng.zhang@intel.com>>=
; Xiong, Tanghong <tanghong.xiong@intel.com<mailto:tanghong.xiong@intel.com=
>>; Liu1, Kai <kai.liu1@intel.com<mailto:kai.liu1@intel.com>>
> Cc: Durgapal, Prakash <prakash.durgapal@radisys.com<mailto:prakash.durgap=
al@radisys.com>>; Pratap Rana <Pratap.Rana@radisys.com<mailto:Pratap.Rana@r=
adisys.com>>; Vijay Kumar Mahto <Vijay.Mahto@radisys.com<mailto:Vijay.Mahto=
@radisys.com>>; Jaydipkumar Dhameliya <Jaydipkumar.Dhameliya@radisys.com<ma=
ilto:Jaydipkumar.Dhameliya@radisys.com>>
> Subject: Re: Request for Review of Fixes Applied for DPDK 24.11 and 25.11=
 Compilation Errors
>=20
>=20
>=20
> Hi Zhang, Liheng<mailto:liheng.zhang@intel.com>,
>=20
> We have verified the behaviour on CU side and confirmed that this is not =
caused by our code. The issue appears to be related to a DPDK bug.
>=20
> At the moment, we do not have any contact information for the DPDK mainta=
iners.
> Could you please check internally and share the relevant maintainer detai=
ls or forward this issue on behalf of Radisys?
>=20
> Thanks & Regards,
>=20
> Reema Sharma
>=20
> ________________________________
>=20
> From: Zhang, Liheng <liheng.zhang@intel.com<mailto:liheng.zhang@intel.com=
>>
> Sent: Friday, March 6, 2026 2:49 PM
> To: Xiong, Tanghong <tanghong.xiong@intel.com<mailto:tanghong.xiong@intel=
=2Ecom>>; Reema Sharma <Reema.Sharma@radisys.com<mailto:Reema.Sharma@radisy=
s.com>>; Liu1, Kai <kai.liu1@intel.com<mailto:kai.liu1@intel.com>>
> Cc: Prakash Durgapal <Prakash.Durgapal@radisys.com<mailto:Prakash.Durgapa=
l@radisys.com>>; Pratap Rana <Pratap.Rana@radisys.com<mailto:Pratap.Rana@ra=
disys.com>>; Vijay Kumar Mahto <Vijay.Mahto@radisys.com<mailto:Vijay.Mahto@=
radisys.com>>; Jaydipkumar Dhameliya <Jaydipkumar.Dhameliya@radisys.com<mai=
lto:Jaydipkumar.Dhameliya@radisys.com>>
> Subject: RE: Request for Review of Fixes Applied for DPDK 24.11 and 25.11=
 Compilation Errors
>=20
>=20
>=20
> The e-mail below is from an external source. Please do not open attachmen=
ts or click links from an unknown or suspicious origin.
>=20
> Hi Reema
>=20
> Looks the changes are ok, but you need verify them by compiling your code.
>=20
> As I know, the following are the better procedures for DPDK bug fix:
>=20
>   1.  Please first confirm the error are not related to your own code bef=
ore changing DPDK code;
>   2.  If it is real DPDK bug, you need contact the according DPDK maintai=
ner to fix it;
>   3.  Finally DPDK maintainer will provide an official patch;
>=20
>=20
>=20
> From: Xiong, Tanghong <tanghong.xiong@intel.com<mailto:tanghong.xiong@int=
el.com>>
> Sent: Friday, March 6, 2026 3:52 PM
> To: Reema Sharma <Reema.Sharma@radisys.com<mailto:Reema.Sharma@radisys.co=
m>>; Liu1, Kai <kai.liu1@intel.com<mailto:kai.liu1@intel.com>>; Zhang, Lihe=
ng <liheng.zhang@intel.com<mailto:liheng.zhang@intel.com>>
> Cc: Durgapal, Prakash <prakash.durgapal@radisys.com<mailto:prakash.durgap=
al@radisys.com>>; Pratap Rana <Pratap.Rana@radisys.com<mailto:Pratap.Rana@r=
adisys.com>>; Vijay Kumar Mahto <Vijay.Mahto@radisys.com<mailto:Vijay.Mahto=
@radisys.com>>; Jaydipkumar Dhameliya <Jaydipkumar.Dhameliya@radisys.com<ma=
ilto:Jaydipkumar.Dhameliya@radisys.com>>
> Subject: RE: Request for Review of Fixes Applied for DPDK 24.11 and 25.11=
 Compilation Errors
>=20
>=20
>=20
> Hello Reema,
>=20
>=20
>=20
> Sorry for late reply, copy @Zhang, Liheng<mailto:liheng.zhang@intel.com> =
here for comment, thanks Liheng in advance.
>=20
>=20
>=20
> BRs,
>=20
> Tanghong
>=20
>=20
>=20
> From: Reema Sharma <Reema.Sharma@radisys.com<mailto:Reema.Sharma@radisys.=
com>>
> Sent: Friday, March 6, 2026 1:41 PM
> To: Xiong, Tanghong <tanghong.xiong@intel.com<mailto:tanghong.xiong@intel=
=2Ecom>>; Liu1, Kai <kai.liu1@intel.com<mailto:kai.liu1@intel.com>>
> Cc: Durgapal, Prakash <prakash.durgapal@radisys.com<mailto:prakash.durgap=
al@radisys.com>>; Pratap Rana <Pratap.Rana@radisys.com<mailto:Pratap.Rana@r=
adisys.com>>; Vijay Kumar Mahto <Vijay.Mahto@radisys.com<mailto:Vijay.Mahto=
@radisys.com>>; Jaydipkumar Dhameliya <Jaydipkumar.Dhameliya@radisys.com<ma=
ilto:Jaydipkumar.Dhameliya@radisys.com>>
> Subject: Re: Request for Review of Fixes Applied for DPDK 24.11 and 25.11=
 Compilation Errors
>=20
>=20
>=20
> Hi Xiong, Tanghong<mailto:tanghong.xiong@intel.com>/ Liu1, Kai<mailto:kai=
=2Eliu1@intel.com>,
>=20
> Hope you are doing well.
>=20
> I am writing to check if there is any update on the pending DPDK issue ra=
ised in this mail.
> Could you please share the latest status, or let me know if any additiona=
l inputs are required from my side to help move this forward?
>=20
> Looking forward to your response.
>=20
> Thanks & Regards,
>=20
> Reema Sharma
>=20
> ________________________________
>=20
> From: Reema Sharma
> Sent: Wednesday, February 11, 2026 11:27 AM
> To: Xiong, Tanghong <tanghong.xiong@intel.com<mailto:tanghong.xiong@intel=
=2Ecom>>; Liu1, Kai <kai.liu1@intel.com<mailto:kai.liu1@intel.com>>
> Cc: Prakash Durgapal <Prakash.Durgapal@radisys.com<mailto:Prakash.Durgapa=
l@radisys.com>>; Pratap Rana <Pratap.Rana@radisys.com<mailto:Pratap.Rana@ra=
disys.com>>; Vijay Kumar Mahto <Vijay.Mahto@radisys.com<mailto:Vijay.Mahto@=
radisys.com>>; Jaydipkumar Dhameliya <Jaydipkumar.Dhameliya@radisys.com<mai=
lto:Jaydipkumar.Dhameliya@radisys.com>>
> Subject: Request for Review of Fixes Applied for DPDK 24.11 and 25.11 Com=
pilation Errors
>=20
>=20
>=20
> Hi Xiong, Tanghong<mailto:tanghong.xiong@intel.com>/ Liu1, Kai<mailto:kai=
=2Eliu1@intel.com>,
>=20
> While compiling the CU with DPDK 24.11 and DPDK 25.11, we encountered the=
 following two errors:
>=20
>   1.  Conflicting type definitions in the DPDK header file rte_bitops.h
>=20
> [cid:image001.png@01DCAD92.9C6111F0]
>=20
>   1.  =E2=80=9Ctemplate with C linkage=E2=80=9D error in the DPDK header =
file rte_cryptodev.h
>=20
> To proceed with our CU compilation, we applied the required fixes in the =
respective DPDK include files and generated a patch named dpdk-24.11_patch_=
for_crypto.patch. The updated changes are included in the attached patch fi=
le for your review.
>=20
> Could you please review these changes from the DPDK side and confirm whet=
her they are acceptable, or advise on the correct fix if modifications are =
required?
>=20
> Thanks & Regards,
> Reema Sharma
>=20





