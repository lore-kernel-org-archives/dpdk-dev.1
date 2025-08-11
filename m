Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F04C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 11:14:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFF394042E;
	Mon, 11 Aug 2025 13:14:55 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id D66974013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 13:14:54 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7e841c71aa6so164946585a.1
 for <dev@dpdk.org>; Mon, 11 Aug 2025 04:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754910894;
 x=1755515694; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GGcm/+N0Dips06/kQI5+2jkbTtcmQcqi5t0f3UqV7Kk=;
 b=2/UIfQUaDWrLxzjEC8Z/7Q9gMQt5nxUOrxfFwBgQNWAk2+pj3OUkp3PzPbCWMbgaDd
 yxcMxnYJtgsY+28Mm5TK2ZG/O7i3NeXYCENGdzWVJp/7cdsbEQZTV+Gts6fVkxL5w9Io
 /2I2UEwwnFD703q3rsenhSglMC96EbAE8n7swNQkPnUf+Pv4OPWCD/wXS9mjpgVvqwiE
 ljWaH6wZ0sQUNVZYehiUGxwAobEbQnjct/YG0Hl7eW8KYDQT7yTbLYl5rqZU4eSt2SmQ
 VmIZXv+cOiN/NnlZyFbZPSKILC5eb8QT6zRm5iEvJk4FTRargKT88iI32IuhjMwpq912
 mnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754910894; x=1755515694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GGcm/+N0Dips06/kQI5+2jkbTtcmQcqi5t0f3UqV7Kk=;
 b=NXvldUijSU6MaetwqGHQAyGz9Grv+G2HQyFMmbmL6oY/YC0mgiURS7ZhPhgHsFtiOl
 /Gv/tzPNUf1tlTJ+eSmjl3z9g4v3ptGegtXXoWeazSlf0MiubYdJGzyjCvBUpXu1Si1Z
 dezcPWzK9I9kdLfryCSB5FQ5lAtF3+NvNnZtan1+SfLre9me2ao5hsfqOXzZmqGARHiH
 O7p6cntkXtQIfLACUJN4XB9k4MBX+9c8Ltw0x2k2bv5At1B1UEabuTDJRpD1qs4RGRXa
 jlIXRm44SZqX2TM4e/jxOaLy0/fOs5LXDWn0jVDw5o2LxwMkCw7HadApShGhAk53/2e8
 jxoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULm+SHb8o2PCJYJ1dstgxlyvs3AE+liXYKY59WzWnMH46fHav97DfvLX/VJ9+4QSFCYLY=@dpdk.org
X-Gm-Message-State: AOJu0Yw5lJ5N1aec/Ahn+hE+SzBvHIcMDarR9X3fWO27PI72DnhZk9oc
 hLLNJmoNMgyWuLovvlVsTwqkshAYjr3ekivfSydRuJpSx1smZsAZAK9mFaVG+Uq1I1/Sa0gLIWt
 AEtC6yrZsjbEvvrKqDwPG4pv9CQA8SBAV+H/6psQAqw==
X-Gm-Gg: ASbGncuR8l5z5ZNaQMYr1tn855mflz360SDetgVwgsJfSYzJ3F0Tex3oCqANDhrTMii
 AMPpC22IMaNf0M6GIJoOs18c/KZHXhYK9i0Fvsyk3GPIOqqyCmCLGP8uvGyH4hw0i35x1dZWsrm
 NXnXBgtl1JjzpGQeMUbJqHid2ixKEQ3O0pvmI8iBbMJl1GxQZzVm8OP/z5jJVgtLi8STNMk9Rjp
 y1c
X-Google-Smtp-Source: AGHT+IFRF3ZPp7fS7mZ8LLXiZwf/nsW9wJSorm+EGqrxjl7m1q35jxhyl92eODM2v0zBSOPU19BAJsq2GeRtZU3pbmY=
X-Received: by 2002:a05:6214:27ed:b0:707:43a1:5b0d with SMTP id
 6a1803df08f44-7099a4ccc66mr131114546d6.41.1754910893825; Mon, 11 Aug 2025
 04:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <PH7PR12MB85968E4B05D92C12C963F1E2822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808114909.1606758-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250808094900.5027f034@hermes.local>
 <PH7PR12MB8596C293ACF92D446DBD10508228A@PH7PR12MB8596.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8596C293ACF92D446DBD10508228A@PH7PR12MB8596.namprd12.prod.outlook.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Mon, 11 Aug 2025 16:14:42 +0500
X-Gm-Features: Ac12FXy4kV4Y1y0IC1nzFerMmVIzMiNPHnyiEE28hHsFhiS7tsVSVMtJIdT7AGs
Message-ID: <CA++2-x4i2OegW0u2a6AJepCFgqjLbwzqdw+es3BqrABgqM7FZg@mail.gmail.com>
Subject: Re: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "Yigit, Ferruh" <Ferruh.Yigit@amd.com>, 
 "andrew.rybchenko@oktetlabs.ru" <andrew.rybchenko@oktetlabs.ru>,
 "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000706f1d063c1508c0"
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

--000000000000706f1d063c1508c0
Content-Type: text/plain; charset="UTF-8"

Hi,
You can create a simple setup with only running testpmd with primary and
another testpmd with secondary and then see the results.

No, the reason for the primary process termination could be close or
shutdown (ctrl + c or ctrl + q) or any other.

The reason is clear: "In secondary processes, accessing
'dev->data->dev_private' or &dev->data->mac_addrs directly can
cause a segmentation fault if the primary process has exited or the
shared memory is unavailable."

The effect is throughput the life-cycle of secondary process existence in
dpdk after primary,
You can check
https://patches.dpdk.org/project/dpdk/patch/20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk/
https://patches.dpdk.org/project/dpdk/patch/20250721105522.1019515-1-14pwcse1224@uetpeshawar.edu.pk/

I think most of the details have already been provided.
The community agrees with the current solution.

Thanks.

--000000000000706f1d063c1508c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div><div>Hi,=C2=A0</div><div>You ca=
n create a simple setup with only running testpmd with primary and another =
testpmd with secondary and then see the results.=C2=A0</div><div><br></div>=
No, the reason for the primary=C2=A0process termination could be close or s=
hutdown (ctrl + c or ctrl + q) or any other.<br><br></div>The reason=C2=A0i=
s clear: &quot;In secondary processes, accessing &#39;dev-&gt;data-&gt;dev_=
private&#39; or &amp;dev-&gt;data-&gt;mac_addrs directly can<br>cause a seg=
mentation fault if the primary process has exited or the<br>shared memory i=
s unavailable.&quot;=C2=A0<br><br></div><div>The effect is throughput=C2=A0=
the life-cycle of secondary process existence in dpdk after primary,=C2=A0<=
/div><div>You can check=C2=A0<br><a href=3D"https://patches.dpdk.org/projec=
t/dpdk/patch/20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk/">https=
://patches.dpdk.org/project/dpdk/patch/20250721073851.963141-1-14pwcse1224@=
uetpeshawar.edu.pk/</a><br><a href=3D"https://patches.dpdk.org/project/dpdk=
/patch/20250721105522.1019515-1-14pwcse1224@uetpeshawar.edu.pk/">https://pa=
tches.dpdk.org/project/dpdk/patch/20250721105522.1019515-1-14pwcse1224@uetp=
eshawar.edu.pk/</a></div><div><br></div><div>I think most of the details ha=
ve already been provided.=C2=A0</div><div>The community agrees with the cur=
rent solution.=C2=A0<br><br></div><div>Thanks.=C2=A0</div><div><br></div></=
div></div>

--000000000000706f1d063c1508c0--
