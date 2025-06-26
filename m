Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C22C77B7F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 04:34:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3DD24067E;
	Thu, 26 Jun 2025 06:34:13 +0200 (CEST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by mails.dpdk.org (Postfix) with ESMTP id 0886F4060F;
 Thu, 26 Jun 2025 06:34:12 +0200 (CEST)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-607ec30df2bso1070980a12.1; 
 Wed, 25 Jun 2025 21:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750912451; x=1751517251; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UKdddVCTy85iXd1E+Ay+pg9YOz4UHG7hfftqffOBdS0=;
 b=A6ggHxsImcH8Hla9mvjhy91PhVzuIkoacUiZhm5PM6v+D4xgrk4QUUSF5BzZRqaHnv
 BUFkrmtYjqL7KVHo97jgg7/yoc8pD4XTq64eNpXSqwnODIepQLKEW6cMDZC/YugmIM6H
 oAWWmLG4W1emletkcSMmBtntlZqogEsljrDWXJsPb2HeNIjjIc7K+ZpyothjTfvLYlVb
 QN0kSl7DnHN3nFZJApJqp8mFPOWBms/ZJ/PcV1O59FiZlrfM8U8wU2T2q/I/Vg43cfB3
 SH7Jdmnuyw0S73aP8UeTykhBRFRrcbByPW6gd/I4IN/ouDRp/4ah2UHsPOafXJJKrNAx
 v6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750912451; x=1751517251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UKdddVCTy85iXd1E+Ay+pg9YOz4UHG7hfftqffOBdS0=;
 b=EJBgYeJow6UaV4m0WAlFHdEnLKSXlkjf4Bl/DaxBJXaMVAFXMpW2lVhuqKqHBRPnOU
 gF+XNo9mcs6YJw3a6VyKKLj4MpPIInav5Yvr/Ay/msTR0GJL2+OHySego2VbayWJh7VD
 5+/WYGqiIOSxVIx6cP8IthzlyPWk2X17ZfgZh/8SKGuBN8vIjfeV4HGVgYhQ1rL4F6Md
 8TpROziCgmtusOzyw0Lgk3k5MWBq+J1AlhmrgAWB6IwoKUzRtSJR/O/dwOC1PoLGrWZA
 OH75eWCGjhFBS4wWgGL1EIxdRy8xRxDCVS30xXdIQA42RBKjpNJOrqWBnbmSw6nvYw1X
 FV1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNSFFuBCIBl7ndzaXs4DS3fhe5/ZwCNS9ZSLoDOLhqdKUW205AW3z653UtIS6eWRceRIym+/Kz@dpdk.org,
 AJvYcCXpbUtkPNs0hPO3GEMyPmrLvSFT+ADWwQMEJSZA9XKAsI92yhvPjujbcqG8t4I9VkM8dsg=@dpdk.org
X-Gm-Message-State: AOJu0Yy5MXkXNJDQpKaCZYwA5jDgVFjUpAMdYZ7hEnsPF1a3JKDXKe6J
 hkYRnzHPNHPmXWc3exTGdKBPcD5T9AUqb9uGZ1FDTjSbd31iA0+scLfvZsrtFk51HJipk7mCVJl
 CLzywLNLxIYRj/irMJgyNQYu0DmYX+rSTxA==
X-Gm-Gg: ASbGnctUijjIFEgBBGt4r8K05ZNoDlnKv+b06IUbG5nSxtgs1C0bD8UwiYz2axk5qms
 gdTAmJf7KBjtfKgHWpowvEYMZ1K2Wv0oUtshxf5eBDu9Ssodg+gqX18ePfWeOdtcwfOub2mztZC
 7v9/YlHHSSAzowR3HWsU/2jVrQUXKfUPCwIgkHL36k6zH3pUDYUkBU
X-Google-Smtp-Source: AGHT+IH+8A+QOZl4tfv08GAyBIX8kwv2Qz0TjIqpUdb+bPzPAWMKTk+5ZZQmeZhf71wQr6a1s87z4aM/YoZjGDcEKzo=
X-Received: by 2002:a17:907:db0a:b0:ae0:9fce:c578 with SMTP id
 a640c23a62f3a-ae0be86192cmr582922266b.18.1750912451181; Wed, 25 Jun 2025
 21:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250621015624.35284-1-amiyaranjan.mohakud@gmail.com>
 <20250623181136.48239-1-amiyaranjan.mohakud@gmail.com>
 <CAL+mCpOU+q542mGrA+aT+nO8Rs4dtAY==U2SbvYJFvVd1e4qCA@mail.gmail.com>
 <DM3PPF7D18F34A1A1141693EF5A3DDF8B588E78A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <CAL+mCpMZDed=QQ-RH0Y0GT095Cnyhz2rsvg8abKuM4_U13-eGw@mail.gmail.com>
 <DM3PPF7D18F34A1770F61E83BA4D365FDDD8E7BA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <aFwdMdNiHftewTi0@bricha3-mobl1.ger.corp.intel.com>
 <CAL+mCpOumEh6H8H6B9eLF=T-Hz6D8HwQOYCMjcAmpWVNS7JnPA@mail.gmail.com>
In-Reply-To: <CAL+mCpOumEh6H8H6B9eLF=T-Hz6D8HwQOYCMjcAmpWVNS7JnPA@mail.gmail.com>
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Date: Thu, 26 Jun 2025 10:04:00 +0530
X-Gm-Features: Ac12FXzD8Uyv7CM8uvovmFFLaaHLTRoVos_xCqxOxYCzn_w5h0oVnsXKbI-pcm8
Message-ID: <CAL+mCpNm36+5Cc=4KLWdGjAOsgNGv+o4xUoMv86Fx7q9rPNngQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/iavf: fix VLAN offload strip flag
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: "Loftus, Ciara" <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "stable@dpdk.org" <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000af80b10638721281"
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

--000000000000af80b10638721281
Content-Type: text/plain; charset="UTF-8"

Just an additional note: It needs to be back ported to all LTS releases
till v22.11. Hope it will be taken care of.

Thanks
Amiya


On Thu, 26 Jun 2025 at 09:04, Amiya Ranjan Mohakud <
amiyaranjan.mohakud@gmail.com> wrote:

> Thanks Bruce and Ciara for the review/acceptance of the patch.
>
> Thanks
> Amiya
>
>
> On Wed, 25 Jun 2025 at 21:31, Bruce Richardson <bruce.richardson@intel.com>
> wrote:
>
>> On Wed, Jun 25, 2025 at 02:01:15PM +0000, Loftus, Ciara wrote:
>> > >
>> > > Thanks.
>> > >
>> > > Just wanted to know  - what are the next steps of the review and
>> approval
>> > > process?
>> > >
>> > > There is a test suite "ci/intel-Testing" failing now with v2 which
>> passed in v1. (
>> > > We know for sure, there is absolutely no code change between v1 and v2
>> > > except the commit message). Is there a way to trigger the test suite
>> again?
>> >
>> > Hi Amiya,
>> >
>> > There is no further action required on your end since the failure seems
>> like an issue with the test infrastructure. If the maintainer for the intel
>> next-net tree is happy with the patch they will pull it into the tree.
>> >
>> > Thanks,
>> > Ciara
>> >
>> Agree test failures look like false positives, as they are errors with the
>> PF driver and virtio driver, while this patch changes the VF driver.
>>
>> Patch applied to dpdk-next-net-intel.
>>
>> Thanks,
>> /Bruce
>>
>

--000000000000af80b10638721281
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div style=3D"font-family:verdana,sans-serif;color:rg=
b(103,78,167)" class=3D"gmail_default">Just an additional note: It needs to=
 be back ported to all LTS releases till v22.11. Hope it will be taken care=
 of.</div><br clear=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail_sign=
ature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><span style=
=3D"font-family:verdana,sans-serif">Thanks</span></div><div><span style=3D"=
font-family:verdana,sans-serif">Amiya</span><br></div></div></div></div><br=
></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr=
" class=3D"gmail_attr">On Thu, 26 Jun 2025 at 09:04, Amiya Ranjan Mohakud &=
lt;<a href=3D"mailto:amiyaranjan.mohakud@gmail.com">amiyaranjan.mohakud@gma=
il.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div dir=3D"ltr"><div><div style=3D"font-family:verdana,sans-serif;co=
lor:rgb(103,78,167)" class=3D"gmail_default">Thanks=C2=A0Bruce and Ciara fo=
r the review/acceptance of the patch.</div><br clear=3D"all"></div><div><di=
v dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><span style=
=3D"font-family:verdana,sans-serif">Thanks</span></div><div><span style=3D"=
font-family:verdana,sans-serif">Amiya</span><br></div></div></div></div><br=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Wed, 25 Jun 2025 at 21:31, Bruce Richardson &lt;<a href=3D"mailto:bruce=
.richardson@intel.com" target=3D"_blank">bruce.richardson@intel.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, =
Jun 25, 2025 at 02:01:15PM +0000, Loftus, Ciara wrote:<br>
&gt; &gt; <br>
&gt; &gt; Thanks.<br>
&gt; &gt; <br>
&gt; &gt; Just wanted to know=C2=A0 - what are the next steps of the review=
 and approval<br>
&gt; &gt; process?<br>
&gt; &gt; <br>
&gt; &gt; There is a test suite &quot;ci/intel-Testing&quot; failing now wi=
th v2 which passed in v1. (<br>
&gt; &gt; We know for sure, there is absolutely no code change between v1 a=
nd v2<br>
&gt; &gt; except the commit message). Is there a way to trigger the test su=
ite again?<br>
&gt; <br>
&gt; Hi Amiya,<br>
&gt; <br>
&gt; There is no further action required on your end since the failure seem=
s like an issue with the test infrastructure. If the maintainer for the int=
el next-net tree is happy with the patch they will pull it into the tree.<b=
r>
&gt; <br>
&gt; Thanks,<br>
&gt; Ciara<br>
&gt; <br>
Agree test failures look like false positives, as they are errors with the<=
br>
PF driver and virtio driver, while this patch changes the VF driver.<br>
<br>
Patch applied to dpdk-next-net-intel.<br>
<br>
Thanks,<br>
/Bruce<br>
</blockquote></div>
</blockquote></div>

--000000000000af80b10638721281--
