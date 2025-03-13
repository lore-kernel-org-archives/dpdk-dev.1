Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4983EC28B28
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 03:40:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2898C40DFD;
	Thu, 13 Mar 2025 04:40:02 +0100 (CET)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 4AAC640B94
 for <dev@dpdk.org>; Thu, 13 Mar 2025 04:40:01 +0100 (CET)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-476805acddaso4970641cf.1
 for <dev@dpdk.org>; Wed, 12 Mar 2025 20:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741837200; x=1742442000; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvNB0wVdgpQ7lY4C4tpMmWw/PPRmtHZyZYXSlY1p+5A=;
 b=FdcqNAI9AWSX+2GGVFR1Mv4hTlGNLDwFsKE/0Jyh0TM2LxFgVxwguWgZHpv0NYQsKE
 Bi3IZvT12hKlWs9fkB8g5aG6pwaWrCCGE+22cZucKELRvFVIYyHga+h1/hNjI4Pq0/IZ
 psfyUUK+uUWe0zIvCEwEVtDbzs0t1OgR4YM4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837200; x=1742442000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uvNB0wVdgpQ7lY4C4tpMmWw/PPRmtHZyZYXSlY1p+5A=;
 b=pMpPeoUrnGt6of1w1QehmsR37o/UfmhBqsCRKrNS9c8a8PbbtpNQsnSnwQdCs8WEGY
 RopXUsOCqCTYkN5OlA1w+VdoQvRpUP1XyIcJBUfcuoA2bo3r4FdP2TZ9nP+pZRRSjoKy
 PdCf//1jK4L5F+34LqlEeSGyCO+hhTv6QRhZdnhQKhuxDrpgYHiH5Nyh+3mLbVIR6HoB
 Vm8v65YPmivw+Mw++GRX7f7R8R2YUZ6kYJVRwutrtvIl4+wi9/JsV/SHvQ3rroV6nrmN
 hvuobyeMQ8JNWccwZIo8DzMHE8hCCHVOapPPc0UimSs4N0D62/pn9Fm2423Y5K72QqYY
 ruHA==
X-Gm-Message-State: AOJu0Yxu8o3kdrGe/10GKx3+HybN2T3iNn6Siiqq6TGiPp73SPZm6nJe
 GzPaZmDqe5UxHDVRn67XMDukrorboaIltbUkKYPjVCrJu8GN/r2Pa1ZgQ/lry70=
X-Gm-Gg: ASbGncvPpS6qEYLDTINftWkwJf9lWphiVQV3kmfVkdMVqwIAPjUEOst2Olwg6Mqn3HZ
 J8l+fBptzksDm44V9pHOPC8U+erOJK+aUJ6OXw0Jv4+hNrW/2cGa5YIe8ATnsmwDXtQAS8cQ4oh
 TvQFO24VhWdNdTZ4ej8nSXZSoNlhHAcnZVgsqq+ELf54loN3i9LwPf56WLfJZGDBCMNC070bAv/
 9W3rjh0OH3EcJ47qH3kvASynKqptfwbn9veIgEPMsu74gFffhO8qLnVeSO3h7FmOWm3QgzS5tps
 rHt95ils/e6o3NmsYPm/4c2MPONTISUbYTsBYnujOh2iok3AA9Bj8DRfF3XApXYiARamXG6Kdyc
 kKG42xWwm6g==
X-Google-Smtp-Source: AGHT+IEfHqmcdhIBilPOIQi+hc7BSofEoY1aZyEl6c22XRzJDWEUYMwYZOiWy70sZXxSLi4MY9RJYA==
X-Received: by 2002:a05:6214:258f:b0:6e8:86d3:be73 with SMTP id
 6a1803df08f44-6e900693295mr407964366d6.37.1741837200378; 
 Wed, 12 Mar 2025 20:40:00 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade257112sm4119716d6.61.2025.03.12.20.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:39:59 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, Luca.Vizzarro@arm.com, npratte@iol.unh.edu,
 dmarx@iol.unh.edu, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v5 0/2] dts: add VFs to the framework
Date: Wed, 12 Mar 2025 23:36:09 -0400
Message-ID: <20250313033611.1896695-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20240821191557.18744-1-jspewock@iol.unh.edu>
References: <20240821191557.18744-1-jspewock@iol.unh.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There currently is no method of creating or managing virtual functions
(VFs) in the new DTS framework but there are multiple test suites in
the old DTS framework that provide testing coverage using them. This
patch adds the functionality to the framework that is needed to create
and use VFs in test suites in the future.

This v5 is a continuation of versions 1-4 which were written by 
Jeremy last year when we were initially looking at VF support.
The main ways that this version differs from his version is that
VF management has been moved to the Port class, and the Port class
has a new attribute, virtual_functions, which is a list of virtual
functions which were created from that physical function. From this
patchseries it should be possible to write functions for the
testsuite API which can leverage VFs on known physical functions.
This will allow us to run virtual function testsuites.

Patrick Robb (2):
  dts: add OS abstractions for creating virtual functions
  dts: add VF configuration and workflow

 dts/framework/config/test_run.py             |  2 ++
 dts/framework/remote_session/dpdk.py         | 11 ++++--
 dts/framework/test_run.py                    |  7 +++-
 dts/framework/testbed_model/linux_session.py | 37 +++++++++++++++++++-
 dts/framework/testbed_model/node.py          |  5 +++
 dts/framework/testbed_model/os_session.py    | 27 ++++++++++++++
 dts/framework/testbed_model/port.py          | 16 +++++++++
 dts/test_run.example.yaml                    |  1 +
 8 files changed, 102 insertions(+), 4 deletions(-)

-- 
2.48.1

