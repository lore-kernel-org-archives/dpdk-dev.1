Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0169C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 03:34:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEFDC40A8A;
	Thu, 26 Jun 2025 05:34:13 +0200 (CEST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by mails.dpdk.org (Postfix) with ESMTP id 897144060F;
 Thu, 26 Jun 2025 05:34:12 +0200 (CEST)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-adb4e36904bso113331566b.1; 
 Wed, 25 Jun 2025 20:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750908852; x=1751513652; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fSlpKloX2vhTWwlU3moTEaGtJU9uNL5MxpWH6IbOqco=;
 b=MZXFSUJLLMt82mxHPe2RCQ9S3qfQdrLYQpeFAqzYtJFIiJ3uUga5n7o0dde0VGCgPn
 yxQcGoecIi3wBYgaHLV7gl5gr/JkWzDZFjDobd/dQx/pYKD3I3jAWcXRY3em82smJcla
 B8p6vOolD+UQcGM5ZjASGbV9AEN55iS5n8pOVZ6NEL1+dv8LN6rMaWkCb+yvV91YEOwA
 mSKwpmls2JWFHZv1xysW9HASIJXd0CtZObG+2m/2FdGEQDhXP4EabMNrrUUal7EPoGT1
 wE3vPmenjtqkqXCykMZ0r0IEqjw+KBORchelSimi2GvVK7kbb96ee5LPbeOCBpfi1dpb
 piYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750908852; x=1751513652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fSlpKloX2vhTWwlU3moTEaGtJU9uNL5MxpWH6IbOqco=;
 b=vfokNaAHY4NoJhNfISaq+AY+/I4BJkTaGlvVK4VcSUQVBC9z9TSIj4GvN/vyJ3ESI1
 AnCBf1efzXMVJu/5GJ3lHWRom7/1i7xV7dy9H8EqWybZaQ6lx9OUf57KZoO7oQpIn///
 bY1MuGE+66oYaDIKLFmVo9W0togKkJWShYfnIT8om03QEK1U4hr2V4Llg5uK8BDlVK8d
 k24bxZG9OT3cwRj6s13Mo4qIXTa3NSwNnTifBCWbFNRsUNSJo2B3HcTF+OmeyrhLrDk5
 uWkyud7jML+gLas42sv9Ke+oZLo6hWJoMxV0MeW1IRL3k47F9MAV6KjsjREkOnmPkDtX
 3QBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1lHxm7nSxLnzZFFZS+NhRq5RRjvcuIlWxETlrb9nyDRUtEWD9IaIL4GiYCwoKjiq5Z7Q=@dpdk.org,
 AJvYcCXU6FFOjn6M3557w8loNZ00U/G/k2JgbidAXGo4/OlKU+oC8Jrg62ZA76dnECnHJk1V7HhxTzCP@dpdk.org
X-Gm-Message-State: AOJu0YwJNEn7eMdwXdD62bV/pWOO20VHRY8JlzqcWqRJlJkQpkuYztdE
 E8f9HVKZ5Ewosb6RSif5qglXDTQqDo0rfEt2WC9bn/e0i9fiGSrOdySvwrYPZb/mUpRKllynWRZ
 2FRVTwrjc/dYM8kHPT5yj8ovdwU3ptzZtrA==
X-Gm-Gg: ASbGncuELwUhh5weVecyX38ZsmtaA5Eks46o6+GTyAKcfwsY8LOJw2WXUHeeKv8e8Pf
 huUrNZgkwJnPTyR29SFYUL2Gl76DOY/4MNVQ+ldubBwxZuzqP8fs/g3ZgqTHO5fEoPSWfy4nrft
 03/bsFjOiA3oYQj4fw3HIY4SdeEqkfjxOENy2lWCBjIg==
X-Google-Smtp-Source: AGHT+IGplPINaERwo1XIWu8txRrt204Uo8I8DdTXWSlK+2a1Tajolf2SPxKaFrWiUzP6u0+ccu6EQKuWC+DAKDMbohE=
X-Received: by 2002:a17:906:6a0c:b0:ae0:5137:fc44 with SMTP id
 a640c23a62f3a-ae0be85f47bmr613940766b.18.1750908851655; Wed, 25 Jun 2025
 20:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250621015624.35284-1-amiyaranjan.mohakud@gmail.com>
 <20250623181136.48239-1-amiyaranjan.mohakud@gmail.com>
 <CAL+mCpOU+q542mGrA+aT+nO8Rs4dtAY==U2SbvYJFvVd1e4qCA@mail.gmail.com>
 <DM3PPF7D18F34A1A1141693EF5A3DDF8B588E78A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <CAL+mCpMZDed=QQ-RH0Y0GT095Cnyhz2rsvg8abKuM4_U13-eGw@mail.gmail.com>
 <DM3PPF7D18F34A1770F61E83BA4D365FDDD8E7BA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <aFwdMdNiHftewTi0@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aFwdMdNiHftewTi0@bricha3-mobl1.ger.corp.intel.com>
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Date: Thu, 26 Jun 2025 09:04:00 +0530
X-Gm-Features: Ac12FXz6c1dMHNoF8Vb_u3mptQXoED3FEnRzhMCB351vg9hDIFPz27oUE_q3FXA
Message-ID: <CAL+mCpOumEh6H8H6B9eLF=T-Hz6D8HwQOYCMjcAmpWVNS7JnPA@mail.gmail.com>
Subject: Re: [PATCH v2] net/iavf: fix VLAN offload strip flag
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: "Loftus, Ciara" <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "stable@dpdk.org" <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000002318820638713c63"
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

--0000000000002318820638713c63
Content-Type: text/plain; charset="UTF-8"

Thanks Bruce and Ciara for the review/acceptance of the patch.

Thanks
Amiya


On Wed, 25 Jun 2025 at 21:31, Bruce Richardson <bruce.richardson@intel.com>
wrote:

> On Wed, Jun 25, 2025 at 02:01:15PM +0000, Loftus, Ciara wrote:
> > >
> > > Thanks.
> > >
> > > Just wanted to know  - what are the next steps of the review and
> approval
> > > process?
> > >
> > > There is a test suite "ci/intel-Testing" failing now with v2 which
> passed in v1. (
> > > We know for sure, there is absolutely no code change between v1 and v2
> > > except the commit message). Is there a way to trigger the test suite
> again?
> >
> > Hi Amiya,
> >
> > There is no further action required on your end since the failure seems
> like an issue with the test infrastructure. If the maintainer for the intel
> next-net tree is happy with the patch they will pull it into the tree.
> >
> > Thanks,
> > Ciara
> >
> Agree test failures look like false positives, as they are errors with the
> PF driver and virtio driver, while this patch changes the VF driver.
>
> Patch applied to dpdk-next-net-intel.
>
> Thanks,
> /Bruce
>

--0000000000002318820638713c63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div style=3D"font-family:verdana,sans-serif;color:rg=
b(103,78,167)" class=3D"gmail_default">Thanks=C2=A0Bruce and Ciara for the =
review/acceptance of the patch.</div><br clear=3D"all"></div><div><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div =
dir=3D"ltr"><div><span style=3D"font-family:verdana,sans-serif">Thanks</spa=
n></div><div><span style=3D"font-family:verdana,sans-serif">Amiya</span><br=
></div></div></div></div><br></div><br><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 25 Jun 2025 at 2=
1:31, Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@intel.com">br=
uce.richardson@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Wed, Jun 25, 2025 at 02:01:15PM +0000, Loftus, C=
iara wrote:<br>
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

--0000000000002318820638713c63--
