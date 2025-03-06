Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A94AC282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 18:56:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 118ED40B94;
	Thu,  6 Mar 2025 19:56:38 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 50D3340B92
 for <dev@dpdk.org>; Thu,  6 Mar 2025 19:56:36 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso755480a91.1
 for <dev@dpdk.org>; Thu, 06 Mar 2025 10:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741287395; x=1741892195; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5rezt2cEfe1f+jYJLE7Rxdy1klha74ID9FPfnPmwCFU=;
 b=C+z58BwrmHYqOYwi2QtU8hP5SzLAJxU4b93NOMrcgKmZB0oepPUbecwqLbFwwAqCIu
 wXYbH8Ih5Z7j/1G1for4XQ5TpOxilo8mH7CRXAKqVytAeUdVoYwS54BuDin6HK95Z+D6
 BusXL+TmBfKvgNR8AhZPJd88Webfr2PfIjWLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741287395; x=1741892195;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5rezt2cEfe1f+jYJLE7Rxdy1klha74ID9FPfnPmwCFU=;
 b=FY8UD8ye4EmI4h/0MOds5GOLTtwULqItGLPcTOGhpiUGjVIWExWFCOoD66QFj03/HB
 e+H7c7sPcjB7lTjJK9Z0H44kbvdrxNCnAj+Oz4TTW26uBDQ2w30jgqikQ2FFwVs2Xamh
 MuEQTWjQYLdyZwwtlUSFiMi6qruc8ZJcGVaRE4hEFei8YE21T1N022TOzHHJgwdAOmKz
 Cmulxs1m7AJ+SBhKETLe/9DDLWGYbILwEYuPQVsNWAAItlrE9/iISpP68CNzqC0iIvoB
 57iORwVUumc0apgk9grWiGjL7FFbcjSaUFblBSkR3PLMmXyM9PgVnWeMM2SkHbA/qN1F
 jj5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE7c9MklJvU9YuR+eIfsK2C5o7cZg5oyd5Y79Hpnxz6zw5ETScs8GWzQUWN9l63m7WgNs=@dpdk.org
X-Gm-Message-State: AOJu0YxDTJIsHCu/McoKQWwG6OTgx1v4FE62odqs5TV4ZsVxs6IL+ILJ
 EDNY1tUc2/mNWUG5CXvJAhwGE5RD/v4BuEHdzTYU/9WUc4ZPu11oVVr08n9dRHxcVydLtzkqSIG
 6c9JmBAXdyAbuqPspjWaO3oYM8e3o5bIRVRcHZSUK3T5xfQUzoG+mFg==
X-Gm-Gg: ASbGnctU8tOCAz0oOdWXbWggK7GatDKrJD4H3DQHrhRk2x5eGmfGlebfhMNdo0I4D0j
 nLr3DPZi5uX7D1FYdxpqbnX836MEqpG4reeCF4S80tAOo9rxnG+l9viZmK+oQMkFVRPiot5Suig
 CFGIGB/+bwFXEI7VREMNbHwjyM8D7HJR9rdfxmOMM/ZeT8TqvJhDJ7N8RDGLY=
X-Google-Smtp-Source: AGHT+IE5E8t/az3CTgta043IzffLP+Ee/q0fvKq66wn04i1in6v2cY1jnuLLUnX16dPpuLgjMN+03Gda4ii63dLDwzc=
X-Received: by 2002:a17:90b:4d12:b0:2ee:aed6:9ec2 with SMTP id
 98e67ed59e1d1-2ff7ce7aa88mr691251a91.14.1741287395304; Thu, 06 Mar 2025
 10:56:35 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 6 Mar 2025 13:52:58 -0500
X-Gm-Features: AQ5f1JqJJz4Gj-T65WFYQ3-_82NzEXiWBfMqkeJ5PCz4DDL5FthQOra-Aoo3UiY
Message-ID: <CAJvnSUCwRgakHWimtK2hjsmF__RKkgRSc5wK-ZyJ6kSp04ddcg@mail.gmail.com>
Subject: Ethertype and Rx/Tx offload suites - collaborate with Luca
To: Dean Marx <dmarx@iol.unh.edu>, Nicholas Pratte <npratte@iol.unh.edu>
Cc: Luca Vizzarro <Luca.Vizzarro@arm.com>,
 Paul Szczepanek <Paul.Szczepanek@arm.com>, dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000a644f0062fb11003"
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

--000000000000a644f0062fb11003
Content-Type: text/plain; charset="UTF-8"

Hi Dean/Nick,

Luca said this morning he is starting to look at Ethertype and rx/tx
offload testsuites. At the CI meeting I gave him an overview of what you
both had learned about these so there isn't double work. My summary:

Ethertype:

1.TPID/VLAN filtering works only on Mellanox NICs and we don't know why so
we are blocked pending this ticket:
https://bugs.dpdk.org/show_bug.cgi?id=1464

2. Nick I mentioned how you were looking at Intel's offering of supporting
non-standard TPIDs and how this was not done by other vendors, and raised
the decision of supporting these testcases, or scoping the testsuite down
to only standard TPIDs.

3.If you can share your patch files with Luca and describe where you landed
with the device capability check for this it may prevent double work.

rx/tx offload:

1.Dean has rebased this series but is running into a bug with the
capability check test parser returning no flags. He confirmed from running
the steps manually that the flags we expect are being reported by testpmd.

2. Dean please provide a summary to Luca so there is no double work.

Thanks guys.

--000000000000a644f0062fb11003
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Dean/Nick,</div><div><br></div><div>Luca said this=
 morning he is starting to look at Ethertype and rx/tx offload testsuites. =
At the CI meeting I gave him an overview of=C2=A0what you both had learned =
about these so there isn&#39;t double work. My summary:</div><div><br></div=
><div>Ethertype:=C2=A0</div><div><br></div><div>1.TPID/VLAN filtering works=
 only on Mellanox NICs and we don&#39;t know why so we are blocked pending =
this ticket: <a href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1464">https=
://bugs.dpdk.org/show_bug.cgi?id=3D1464</a></div><div><br></div><div>2. Nic=
k I mentioned how you were looking at Intel&#39;s offering of supporting no=
n-standard TPIDs and how this was not done by other vendors, and raised the=
 decision of supporting these testcases, or scoping the testsuite down to o=
nly standard TPIDs.=C2=A0</div><div><br></div><div>3.If you can share your =
patch files with Luca and describe where you landed with the device capabil=
ity check for this it may prevent double work.</div><div><br></div><div>rx/=
tx offload:=C2=A0</div><div><br></div><div>1.Dean has rebased this series b=
ut is running into a bug with the capability check test parser returning no=
 flags. He confirmed from running the steps manually that the flags we expe=
ct are being reported by testpmd.=C2=A0</div><div><br></div><div>2. Dean pl=
ease provide a summary to Luca so there is no double work.</div><div><br></=
div><div>Thanks guys.</div></div>

--000000000000a644f0062fb11003--
