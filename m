Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0288ACFD364
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 08:07:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D88540A6B;
	Tue, 25 Nov 2025 09:07:13 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 68AB540267
 for <dev@dpdk.org>; Fri, 21 Nov 2025 15:15:52 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-34585428e33so2042937a91.3
 for <dev@dpdk.org>; Fri, 21 Nov 2025 06:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763734551; x=1764339351; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LwPDdARQ8MF2Q1rdntRXPQLs0kz/m05yZBsDWk6kCHU=;
 b=XSmFSiuttcfzOe0v6fbuyZ+DWmE21xtXbA0Ie6k+7u9MChPqakbrH1EnKyqLOmZ6g3
 UM8uuib/Y9hhzQn5kQiRl8UOPJbhOmQGxki+QD0n2bSGr/9a7/E/H7zgEbGKBeHXdkfo
 Z8l8/7oq/mivBlhLsfWAoBdGp3zj+N7zs1bpjNuSsva0MGYHe9Grab3crxxRekCOhm3o
 eS71uOB+mwYJrxQ+fynTkjOhV3Re9renEABGUDpy5RnriVTbf20aAqQHoolwihe6MJbH
 XUMJOaiVKbl9+E8vOaVuJ4tq5zUDYBMBVor+zQyjlCEcT8W6IXNDLDxvTXj7Z84VywKq
 /leQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763734551; x=1764339351;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LwPDdARQ8MF2Q1rdntRXPQLs0kz/m05yZBsDWk6kCHU=;
 b=wyl7kaoqSBLtuCga6eGVdUhRfkknMdJ9h686J7fdGBFYLHGE7PtKlBz74doq+QxDiC
 tW8eHZmq1HCScAK3lb9oiw7ua1aMfRyVNXutoEl4wSbmFAFQjFBAjxKs4mq+jgKluEZn
 cNytU9viNxY9j2Bj3eg2OQmNKVMzLTsnIK6PTKNql0yoHpzEc9rMOPTz6ZdnjoCjEM7F
 5mGsKoJP0OBqzvntnBnWMSMDivb3KQcYtUEt8jXUcpq61Y10Jgz1S8kitc+S40IT8dJb
 jF8gDbKQvQeELoCeJY2N3lZwa+9qZ/BD5+HubSttBluJYaP79o4ef3ihCAeUPqsCqRlx
 8idQ==
X-Gm-Message-State: AOJu0Yz+x4z9KJdA1/MYUNCZL+B/S+D0ZW1u8/HSVzmam03cbw2phBQd
 5u1tStnM0ht2KXs/7U0qFLAGfS7czSEYmZS+vfTQvU3O2zpFK7yKxYe7BsxCEnFedp+pkmkiOlE
 DP7GbW8eCfLLge3KHehxDf2KSx0cO4v04Dtc1
X-Gm-Gg: ASbGncsItby9f1xY5r14i+faMw5kspriuUC/h5e/SJOoNux3fSRJhhzUyP9SLo/uNds
 z/n1fi6T3dA6nZ88xg1k3EKoWr+gOLMkhyi7Ny28IORl0evZoDYWqWNXuuQx/PfcZX3TDLDjSaa
 ohSvwIpdg74JhWepv0EN2vaNnsKrw80CZOzjSpFSaTdXL1PQn23vRV7Shrg9BHvJBonWiXqeqUb
 8uRMxgHrim3JOFn3ZVpL4k8mEtrPTLX1HGMvBg77vTuaB7sblPfxAmitQcPsP8Z4BapTqbi
X-Google-Smtp-Source: AGHT+IGpPPkK8akg5iCsQss6quKgiH8TZQ0u6fsOleiHhgaldpF0onR0ZWzqUoA3/KrdxDAoAzHV/3slOEDclm9kDTM=
X-Received: by 2002:a17:90b:4a11:b0:33b:938c:570a with SMTP id
 98e67ed59e1d1-34733f3d11emr2864203a91.33.1763734549987; Fri, 21 Nov 2025
 06:15:49 -0800 (PST)
MIME-Version: 1.0
From: Wan Bingbing <wantmac.bingbing91@gmail.com>
Date: Fri, 21 Nov 2025 22:15:39 +0800
X-Gm-Features: AWmQ_bmr0GSnUGRRWkd79ZyGLg9yPA0YQu1UDIQ49fwEBSxU3njp_OsirNdN0vk
Message-ID: <CAN-dPwmgoCzwcp46xyz3EPEP7BUL58aO3em2Tot2zqieg5wYQw@mail.gmail.com>
Subject: Question: PMD behaviour without hugepages in DPDK 23.07 (XDP PMD in
 Kubernetes)
To: dev@dpdk.org
Cc: "chenxiemin@gmail.com" <chenxiemin@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000549d8d06441b73c1"
X-Mailman-Approved-At: Tue, 25 Nov 2025 09:07:12 +0100
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

--000000000000549d8d06441b73c1
Content-Type: text/plain; charset="UTF-8"

Dear DPDK team,

We are currently deploying an application utilizing Seastar and DPDK
(version 23.07) with the XDP PMD inside a Kubernetes environment. Due to
infrastructure restrictions, we cannot allocate hugepages on the Kubernetes
nodes.

In this environment, DPDK fails to initialize the XDP PMD because
hugepage-backed memory cannot be created. Although the EAL is not started
with the --no-huge parameter, no hugepages are available to DPDK,
preventing the PMD from sending or receiving packets.

We are aware of the known issue documented in the DPDK release notes ("PMD
does not work with --no-huge EAL command line parameter"), which explains
that PMDs rely on hugepage-backed memory because DPDK does not store the
necessary physical/IOVA information for memory allocated via malloc/mmap.

Given this dependency, we have the following questions:

1. Is there a currently supported method to run a hardware PMD
(specifically the XDP PMD) without hugepages, or is hugepage-backed memory
strictly required for all hardware PMDs?
2. Are there any ongoing efforts or future plans to support PMD operation
in a non-hugepage mode?
3. If this limitation is architectural and not planned to be addressed,
could you please confirm this? This confirmation would allow us to evaluate
alternative approaches, such as using AF_XDP without DPDK or relying on the
Seastar native stack.

Any guidance or recommendations from the maintainers on how to proceed
would be greatly appreciated.

Thank you for your time.

Best regards,
Wan Bingbing

--000000000000549d8d06441b73c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear DPDK team,</div><div><br></div><div>We are curre=
ntly deploying an application utilizing Seastar and DPDK (version 23.07) wi=
th the XDP PMD inside a Kubernetes environment. Due to infrastructure restr=
ictions, we cannot allocate hugepages on the Kubernetes nodes.</div><div><b=
r></div><div>In this environment, DPDK fails to initialize the XDP PMD beca=
use hugepage-backed memory cannot be created. Although the EAL is not start=
ed with the --no-huge parameter, no hugepages are available to DPDK, preven=
ting the PMD from sending or receiving packets.</div><div><br></div><div>We=
 are aware of the known issue documented in the DPDK release notes (&quot;P=
MD does not work with --no-huge EAL command line parameter&quot;), which ex=
plains that PMDs rely on hugepage-backed memory because DPDK does not store=
 the necessary physical/IOVA information for memory allocated via malloc/mm=
ap.</div><div><br></div><div>Given this dependency, we have the following q=
uestions:</div><div><br></div><div>1.  Is there a currently supported metho=
d to run a hardware PMD (specifically the XDP PMD) without hugepages, or is=
 hugepage-backed memory strictly required for all hardware PMDs?</div><div>=
2.  Are there any ongoing efforts or future plans to support PMD operation =
in a non-hugepage mode?</div><div>3.  If this limitation is architectural a=
nd not planned to be addressed, could you please confirm this? This confirm=
ation would allow us to evaluate alternative approaches, such as using AF_X=
DP without DPDK or relying on the Seastar native stack.</div><div><br></div=
><div>Any guidance or recommendations from the maintainers on how to procee=
d would be greatly appreciated.</div><div><br></div><div>Thank you for your=
 time.</div><div><br></div><div>Best regards,</div><div>Wan Bingbing</div><=
/div>

--000000000000549d8d06441b73c1--
