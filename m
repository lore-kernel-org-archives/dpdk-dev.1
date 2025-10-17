Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73CECCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 13:45:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 014FC42D45;
	Fri, 17 Oct 2025 15:45:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C945F42D45
 for <dev@dpdk.org>; Fri, 17 Oct 2025 15:45:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760708734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wYpfCRRvqtyfX5aYzOKxDAd2ehCCi4TCMgZmG38eK4A=;
 b=MI3KOM818UWCrXPoQkDBdZGGXQtcAj/XZHsDbybqPBedj5VIwj+VVJAHRDFHU4+gaY2Tyc
 KmKaNx+FVXNr1XxgWRABOXQypXt66XTIUuWwded0YHZ5CWYm3JYcWnATfBJEKEfTqRiD5u
 hISDwfPLBkfmCvOx93h8SEkW5DoA8ks=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-w8RV-LuSP9WeGZbsjfNV2Q-1; Fri, 17 Oct 2025 09:45:30 -0400
X-MC-Unique: w8RV-LuSP9WeGZbsjfNV2Q-1
X-Mimecast-MFC-AGG-ID: w8RV-LuSP9WeGZbsjfNV2Q_1760708729
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47108e1d170so1847605e9.3
 for <dev@dpdk.org>; Fri, 17 Oct 2025 06:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760708728; x=1761313528;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wo6ra5bTIcHtONRvdIjG6gLca1MOwZLsrfiUfUfe+yg=;
 b=DNQ6tEG6ATH6MMxVhrllFvInNZ45/dkwT1LLE3X0TnJklg/3eJKnpxL77twWFKt9OB
 c2U6SgNvtHdQsIGt35Gy1P6atnWaibqbY8oVta9NcxxzMzPzi6+gooaAQXyPn20kqJk2
 cqhR8YKYJNh2q28uXzqfu9cclTJXRz5RRgAg8kzPfl09VlDkqv0tjrMJklnAq1Cj/2z3
 EoK69qaMX2O0+9OMl+IltaQmF40EZjUEbrArti5Z/czGVsfars7jg32c7BV6b9kNGH0u
 H/u6gf+cjySjIMjNucQ/SUG/xFWmSWZqx7YQ2d/+QIRDnzc4RyDY3/j9qxQXWdcrOMQS
 Iyhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFGi6xVcexVpyPnQjSMUtgPGCLgXPMTRWpXFZKkd0Un/s+u994oAa0ZNZhpfy6lgRTQ1M=@dpdk.org
X-Gm-Message-State: AOJu0YxP9h86VKjXXHz4j9FY4ZWm1s0vQHbylYWar9iHSNZcPsU1BCa7
 MQxOuQ/udGfVwmnk8x46Og1gsZxU7w2GTUddVNm/KrpqF1SKO8aB1KZJRzkF9rZu4OdZ+knSmFy
 6udwhfU7A6pOuwTlTk5MZT7ugZnId0Rij0WKIprRw/2iTNkeEGck2
X-Gm-Gg: ASbGnctJNQCb9xByeDJjVMmDONi5sH0B97IdY8/lTFI2lmLc7pF2aJfIzd4OAg6jtr5
 aww6890QXwpPrZ2D5qIAYPspRoEQ5qjl/Gsn2Gl8XGNnbdi4VWuRxw3+vnycUzqXSUqycWdfdLc
 aeTuhvX/naHGDsyXiaGWR75HD7J33KpzBEZSAw9o3sspEWLjVQYipiUX8PJtiMvw2iTGKF8Eu1+
 KIlkfzYV1CY+aIIPA4X4Mlv/AO1nYSDe0Ecklsr8guHo3Xn3pZkbu3EJoxA32laOkedMCemkire
 XmoXc9USvFLvQPgY5DvukE2V+c3iOA0QFBJeWHq3FnfvExlyqTwQ1XfCC+fTgq+Q1X4esdVmR+A
 1qdHIH/aBoSwNSFUWbgEBL0oco9922RUyQJ8YCGkWe9iVYCe/tCBxVsBcqw==
X-Received: by 2002:a05:600c:a4a:b0:471:5bf:cd02 with SMTP id
 5b1f17b1804b1-4711787c837mr28139565e9.11.1760708728600; 
 Fri, 17 Oct 2025 06:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBeuUZejb3ptziidx8iFptRALMWkDp9BCMPthS+YH0IKQEwO+GLdv3R58Zk4o+ZVkFqdtIRQ==
X-Received: by 2002:a05:600c:a4a:b0:471:5bf:cd02 with SMTP id
 5b1f17b1804b1-4711787c837mr28139325e9.11.1760708728145; 
 Fri, 17 Oct 2025 06:45:28 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711442d6c6sm80105185e9.6.2025.10.17.06.45.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 06:45:27 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 17 Oct 2025 15:45:27 +0200
Message-Id: <DDKN5IUVL6Y2.3MANZ0QIRGHUH@redhat.com>
Cc: "Marat Khalili" <marat.khalili@huawei.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v3 1/2] devtools/mailmap_ctl: script to work with mailmap
User-Agent: aerc/0.21.0-9-ga57e783008e9
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20251017133812.1109638-1-bruce.richardson@intel.com>
 <20251017133812.1109638-2-bruce.richardson@intel.com>
In-Reply-To: <20251017133812.1109638-2-bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r_hcNxWpvVn5nLjA2GnbIsqXCTPqTHWGaACqAZsoJ6o_1760708729
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Bruce Richardson, Oct 17, 2025 at 15:38:
> Add a script to easily add entries to, check and sort the mailmap file.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> ---

Hey Bruce, I only have a couple of minor remarks:

$ isort --profile black --diff devtools/mailmap_ctl.py
--- devtools/mailmap_ctl.py:before=092025-10-17 15:42:59.507233
+++ devtools/mailmap_ctl.py:after=092025-10-17 15:43:03.351551
@@ -6,13 +6,13 @@
 A tool for manipulating the .mailmap file in DPDK repository.
 """

-import sys
-import re
 import argparse
 import itertools
+import re
+import sys
 import unicodedata
+from dataclasses import dataclass
 from pathlib import Path
-from dataclasses import dataclass


$ ruff check devtools/mailmap_ctl.py
devtools/mailmap_ctl.py:171:5: F841 Local variable `operations` is assigned=
 to but never used
    |
169 |     """Main function."""
170 |     # ops and functions implementing them
171 |     operations =3D {"add": add_entry, "check": check_mailmap, "sort":=
 sort_mailmap}
    |     ^^^^^^^^^^ F841
172 |
173 |     parser =3D argparse.ArgumentParser(
    |
    =3D help: Remove assignment to unused variable `operations`

Found 1 error.
No fixes available (1 hidden fix can be enabled with the `--unsafe-fixes` o=
ption).


With these fixed:

Reviewed-by: Robin Jarry <rjarry@redhat.com>

Thanks!

--=20
Robin

> 98% lean.

