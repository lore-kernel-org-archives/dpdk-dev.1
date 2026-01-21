Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F8DC44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 20:41:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72F4E42E69;
	Wed, 21 Jan 2026 21:41:20 +0100 (CET)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id A5CFA4027A
 for <dev@dpdk.org>; Wed, 21 Jan 2026 21:41:19 +0100 (CET)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-11f36012fb2so500547c88.1
 for <dev@dpdk.org>; Wed, 21 Jan 2026 12:41:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769028079; cv=none;
 d=google.com; s=arc-20240605;
 b=k4cPx0LKYzkOKwFd+l5iASuqXhJQvJ9VWMchbuoYSQi00fkOXPy+2sB1mQj72w103+
 3R9JKGCUDQXaSDqUClBssdgG1XqIzQ1ZYh98Y2Mt6V4WIIJ4HcGJV2d00b85sz4N5AFJ
 wW9utayaoYwqAB97fbMqWVddZI6Oci5wU6wNM1Rzj6vlCgwzN6WJhC650/Rs8z/cWY+N
 /TQG2zaRfMplZXZ5yApxJttanPVyzB+YoaKLGk0AYCRlYfPO70FPiXZGHMGfhESZUd+H
 CaX8Qa7eJssNppGnqcvi4qBkDhTGXXenHGzo+/uHBMFUgcGYLWdc28QUFTNr8IEwxjp8
 Ojzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lfmG7Ezsegs+BHOjvAJmF7VKxc5qQNXqx3YYZOS5pJM=;
 fh=eLt9PNebyemN6exqXlDvBptaKX+Ksopk61MUlaCfAI8=;
 b=MJgTqRbXuvN4LxzN2NqTnZ8nv1HU1GJv5nRJMHhIsd1Md1+wSkWWCqe4aD383tl5F2
 Q+nTcIVwvGpGZgGvWzmjIloYer17iZbZ6KqlFwaC8s5fs9jyuZuz6KWFJ98phOSrXXE5
 Mf67/FaABjfoD3Yjz+fzk5chlLQfFB8yIDnSwg2/IjBEM7aUX6kAVVVdyRqxZJPPBLR0
 VrYL/zHK0+PwyZPHur/32eQWbhhCtnu5/7Cxs9WmWKvIt8neCe9/hq+suaMTXO6DY8q7
 3G1+IXHCMCNmnwgO1VJIS7F/FXfRujYay2bSOtvFdshk2OW7MY3VvwnUf/Ti9nOycQGw
 +WUw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769028079; x=1769632879; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lfmG7Ezsegs+BHOjvAJmF7VKxc5qQNXqx3YYZOS5pJM=;
 b=DN4D10XZTFqVi9//noRrRIxFG215fcjLOcGwQUuThpPhVn/e9RAEm2bETKZ+h+hN1Z
 n7aVAl+/SC3oiP6AbpC2S2wwE/pc5tgK70Vm3/xhzL0htiaXNOHhGOI+qm+thrAPofPI
 5NVjWpBsWqSHPbZlvhfCMFOco6kyePk9lDHe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769028079; x=1769632879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfmG7Ezsegs+BHOjvAJmF7VKxc5qQNXqx3YYZOS5pJM=;
 b=QeRex/bTPaegl0dGAY/rUSqOBgPnBDJxuo+JY2Rwbiu4eqHQPFdPvKfQqYm8NyE2BK
 nLOhZg82WHbCeeMT4xj10juaYFA6zWGqQXqqLbsdw4RpDZcVJO4Kb5OJOYycoSxYsZdQ
 8WkWa4WYVBsob2EPPx0FuMxgULgVNWkeGPCR58ux0aUBgsTkZoz2n07+YDDtg3yANd2C
 m7Ntjbod8Hfl+3m5cCym4yq6nshqHA2d6IV+cTrgOCjP03N/TCqlEbPiEanA21F5/xY3
 QuBnrVt0V08eRNok+Op60+2uTtis/0FIdVMdmNk3Ln//mj7ozuXdQ1WavPDN/NzxFZl4
 pz/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgFbh+UvNqKmqk4ZSWg1IoNVRWJLLj8SPVL6Gqn5zM9AUqRp+Ztdy8gTXnAhDUAEXo/oQ=@dpdk.org
X-Gm-Message-State: AOJu0YwZUzSdL05QFSCwaMEhYC7RkkLjQCBx4Eb7/iwFWzN3STf3Xuka
 6K9ZY5OUan38dZeE2BVIiRPJIlxq9nshODMrEv3OgZUaShaYOQMO+RvA79fAZNtPsvABaC1CeZi
 3qi2sA7YNMrH5oj1Mi+QTFtCvswMe2f8D5GPYRkl7MA==
X-Gm-Gg: AZuq6aJE2tq/uhN90oadQJNV05cU3ukrM9oosAH1TNIu6dmTJyfClVGfqQxa+STQVWt
 jXEIZCPqAYzgRVB3KMwJCRQ70B991V5qn8a4SU9lEBhW2lg0/vpsE8J8/yi19UA15647n98oEgO
 DawJy73+Gs7IRQvpOq4iqZdI7zsFi3+zg17Qe0e3RhExjrM1eJYijKaCA6tBIt0zW9hPbNypcoI
 svjNxhw0rv34vgxnQS/p5XhmDLrrWHvr9WrGw+hc2UX9RAEWps1WjLjx+UYKDNSAe2wp9IOuJ0/
 xy7f3ewO/8dvlEkDNPWfZbK9cZbrb00IEgR+K6XmRWLMkELldkzSmefuFX5b
X-Received: by 2002:a05:7022:250f:b0:119:e56b:91ec with SMTP id
 a92af1059eb24-1244b35f831mr11609239c88.29.1769028078173; Wed, 21 Jan 2026
 12:41:18 -0800 (PST)
MIME-Version: 1.0
References: <20260105190647.63244-1-abailey@iol.unh.edu>
 <20260105190647.63244-3-abailey@iol.unh.edu>
 <CAJvnSUBTtGyQ7WtE9GF-gawS=A8rHAqcaqTSo8eWYa+GBkhRwg@mail.gmail.com>
 <CABJ3N2W6QXQ1Aae4QWaZhSMrwMfmDa6oYjHby1YDQJdK2FknvA@mail.gmail.com>
 <CABJ3N2VTZc-73hP=0KG8EPbdrCexYZXToLzhJPAhkN+Eo77DWg@mail.gmail.com>
 <CO6PR18MB4484327639EC118ACFFF3810D881A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABJ3N2Vf=guy5qJmmbTHY76Bnnn-5PTEkmB+FewahHqDzxJLiw@mail.gmail.com>
 <CO6PR18MB4484D1EF6B0BDF1205164276D896A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484D1EF6B0BDF1205164276D896A@CO6PR18MB4484.namprd18.prod.outlook.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 21 Jan 2026 15:39:00 -0500
X-Gm-Features: AZwV_Qg3i3sYig5ezJ90BxJkOwbtS6_l9gE5WZ5R6b8IZtC3bbrK-3hqqhL6xb4
Message-ID: <CAJvnSUAJB4vWcb-A3XYUb8T2fECsrc4UnBR73FnemjPX3=x4EQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 3/3] dts: add cryptodev testsuite
To: Akhil Goyal <gakhil@marvell.com>
Cc: Andrew Bailey <abailey@iol.unh.edu>, Kai Ji <kai.ji@intel.com>, 
 "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>,
 "luca.vizzarro@arm.com" <luca.vizzarro@arm.com>, 
 "dmarx@iol.unh.edu" <dmarx@iol.unh.edu>, "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="00000000000032925e0648ebf23a"
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

--00000000000032925e0648ebf23a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 2:39=E2=80=AFPM Akhil Goyal <gakhil@marvell.com> wr=
ote:

> IMO, it varies from platform to platform. Adding Kai Ji for details on QA=
T.
>
> However, you can use as many VFs as you want. Generally, we use 1VF per
> core.
>
>
>
> Do you plan to include other platforms as well?
>
> How about openssl PMD?
>
>
>

I'll jump in as Andrew is clocked out for today.

Yes we will include testcases for the OpenSSL vdev PMD. For instance in
Andrew's RFC the first testcase is "openssl_aead_aes_gcm_encrypt." I guess
the only decision to be made there is whether we want to group that under a
separate testsuite (software based cryptodev testing) or whether we keep
HW/SW testing on the same testsuite (this sounds fine to me). Yes we should
add in other valid options like openssl aes-ccm (andrew see
https://doc.dpdk.org/guides/cryptodevs/overview.html) and those will be
available in the final version for DPDK 26.03.

Yes, the DTS testsuite should support all platforms which dpdk-crypto-perf
can, not just QAT. We are using QAT as an example (and using it to run the
testsuite) because we have a QAT 8970 on one of our servers at UNH. We also
have a CN10K with a crypto device but have had issues with VF creation on
it in the past and are only running ethdev testing with that board. I can't
tell whether there is a software or hardware issue but once the testsuite
is ready I would like to rebuild the Marvell SDK and the ubuntu buildroot
OS and "clean install" the board to see if we can get Andrew's cryptodev
testsuite running on CN10K for testing.

But, in general one should be able to install any crypto device on their
system and run this testsuite (the testsuite is not device specific). If a
cipher algorithm is not supported by the device, the testcase skips. If it
is supported, it will run and return a pass or fail.

--00000000000032925e0648ebf23a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 21,=
 2026 at 2:39=E2=80=AFPM Akhil Goyal &lt;<a href=3D"mailto:gakhil@marvell.c=
om">gakhil@marvell.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div class=3D"msg643243302388421437">





<div lang=3D"EN-US" style=3D"overflow-wrap: break-word;">
<div class=3D"m_643243302388421437WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">IMO, it varies from p=
latform to platform. Adding Kai Ji for details on QAT.<u></u><u></u></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">However, you can use =
as many VFs as you want. Generally, we use 1VF per core.<u></u><u></u></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Do you plan to includ=
e other platforms as well?<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">How about openssl PMD=
?<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt"><u></u>=C2=A0<br></sp=
an></p></div></div></div></blockquote><div><br></div><div id=3D"gmail-:pp" =
class=3D"gmail-Am gmail-aiL gmail-aO9 gmail-Al editable gmail-LW-avf gmail-=
tS-tW gmail-tS-tY" aria-label=3D"Message Body" role=3D"textbox" aria-multil=
ine=3D"true" tabindex=3D"1" style=3D"direction:ltr;min-height:85px" aria-co=
ntrols=3D":180" aria-expanded=3D"false"><div>I&#39;ll jump in as Andrew is =
clocked out for today.<br><br>Yes we will include testcases for the OpenSSL=
 vdev PMD. For instance in Andrew&#39;s RFC the first testcase is &quot;ope=
nssl_aead_aes_gcm_encrypt.&quot; I guess the only decision to be made there=
 is whether we want to group that under=C2=A0a separate testsuite (software=
 based cryptodev testing) or whether we keep HW/SW testing on the same test=
suite (this sounds fine to me). Yes we should add in other valid options li=
ke openssl aes-ccm (andrew see=C2=A0<a href=3D"https://doc.dpdk.org/guides/=
cryptodevs/overview.html">https://doc.dpdk.org/guides/cryptodevs/overview.h=
tml</a>) and those will be available in the final version for DPDK 26.03.</=
div><div><br></div><div>Yes, the DTS testsuite should=C2=A0support all plat=
forms which dpdk-crypto-perf can, not just QAT. We are using QAT as an exam=
ple (and using it to run the testsuite) because we have a QAT 8970 on one o=
f our servers at UNH. We also have a CN10K with a crypto device but have ha=
d issues with VF creation on it in the past and are only running ethdev tes=
ting with that board. I can&#39;t tell whether there is a software or hardw=
are=C2=A0issue but once the testsuite is ready I would like to rebuild the =
Marvell SDK and the ubuntu buildroot OS and &quot;clean install&quot; the=
=C2=A0board to see if we can get Andrew&#39;s cryptodev testsuite running o=
n CN10K for testing.</div><div><br></div></div><div>But, in general one sho=
uld be able to install any crypto device on their system and run this tests=
uite (the testsuite is not device specific). If a cipher algorithm is not s=
upported by the device, the testcase skips. If it is supported, it will run=
 and return a pass or fail.=C2=A0</div></div></div>

--00000000000032925e0648ebf23a--
