Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ED4F34C65
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 16:46:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61D3A402CA;
	Mon, 13 Apr 2026 18:46:58 +0200 (CEST)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46]) by mails.dpdk.org (Postfix) with ESMTP id CC0664021E
 for <dev@dpdk.org>; Mon, 13 Apr 2026 18:46:56 +0200 (CEST)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7d7f92bde91so2892214a34.1
 for <dev@dpdk.org>; Mon, 13 Apr 2026 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776098816;
 x=1776703616; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDa50izIhlVHsMbF9w8sREHcB3EtQPVZdiSh2d/Q+pM=;
 b=SAo1WNd9CMvEqym5ZEqr1Ov3audEjqxz+UWvl3IRBc5c8CjKjf72MUdFI+Szfbg+PC
 Tnvjrx451m+NWIJThFSKEv1QJ6tjvQVsCvHxLpey9RqEFyxCJJbGqSCO+7jrfbxiHcm6
 T26XykpPRjPjEqoJQKcXgtQ6fAjISElkFqqwCxG1+jaahSiz3U959FOYLhElTIK3XN6b
 wJdW/PpBowf1ogRUGB1QSuZJLzlhGFBmumZswdNY+8MGSXotatyDrVcvvynipatZo8+3
 4TDCB2WozrKz5b2PsA3jlnPM89aG7smaJ9yS1AIbdcvJ8fEz/pov13CjhM1vWjGeNucl
 C29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776098816; x=1776703616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VDa50izIhlVHsMbF9w8sREHcB3EtQPVZdiSh2d/Q+pM=;
 b=XYUG+KxaLm6fiGSMYIkgDrFCbFs+bK79dhkOIeg23nznGXU1+QoN5mTDHK8zT1ZhtZ
 IObI6+xa27TeNf2LZDRdknIdxOQHJrohffX2Yll/lkv5qBd63LpvAiuyvmScgHatpsq3
 lhjjG6tqzTrbcT+nln9qYrS8Laj77GUheXy0FZTKwH9FbLa2wjGODKGTEM8K9UQxTiHu
 /LKbkN1D/zzK5zzP6z/FqsgsextsXh+2+mJg0ZA/vwcm8PQwiNj1vSy87YLLBsXv1NOo
 Rgzgc6Q3+YGtS9guxpinlUAaZrKODWkxDYN3Rsdj10Y1zcV8BevMqJl7+wctWSbNdE3z
 b7Uw==
X-Gm-Message-State: AOJu0YzhffEkNQxDSMzW5jspHjANJ3tvhdnnjPQhwBY+MouwDOoE4mJm
 WgwOAIPuepdfqk+YLJ71lC/nccZ++af7TcI5DOMGv41P4dIYWVUYVI2cioTxO1K9HpQyDKSYpaU
 413u6
X-Gm-Gg: AeBDievQNshRK1gYhPxA2ZupKb601onNbGQFtqFkOM+YvAQWcxs8W3zi0gVQ8OALv8a
 HCxu+J3MkX+HwPRK29ECh1Z40ZilNx2VgrzDXIbviCE6GOF4wpnwsEXAW6g+D6l6M6ktXSoFCYJ
 VE9qTAKYrqEM23m/i5G4oANamP3Iv97TZKq6JRVgQxW5c8mH+C3NITY3BKYN5NEhgZCZOHoaP2X
 hAZHnmWzJOYxBFZYDYHAkx+WL8xAQkRlzDC8PwP5RImNmzRc9C0RHC5CSjSMtRvmPg974c2T70n
 70Cq5BwY0fi+mPYu3tO/uvhMmsocCPIGDGn4GgvxQcNPE4h7BssdRqXA3fc8JWFdlLffTWEnt3v
 jweBLrp78QR4zMizjhNdICAdlmjLyAvRLdl0pmPR1wptxzJ8D3guzsNkmkLp71ItB+mNmlLe5S/
 bFBn0mFzypVtqhexKQ62TvtRh+7Y1IC+Pwlzfs3Dvv1cE=
X-Received: by 2002:a05:6830:67e3:b0:7d9:7201:1acf with SMTP id
 46e09a7af769-7dc27c7b32dmr9109363a34.5.1776098815561; 
 Mon, 13 Apr 2026 09:46:55 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc3959099fsm6218089a34.9.2026.04.13.09.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 09:46:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/3] Add pause to empty spin loops
Date: Mon, 13 Apr 2026 09:45:28 -0700
Message-ID: <20260413164652.33291-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260121180845.889190-1-stephen@networkplumber.org>
References: <20260121180845.889190-1-stephen@networkplumber.org>
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

On SMT systems, empty spinloops can cause excessive latency due to
the spinning core consuming resources that could be used by other
hardware threads. This series addresses this by adding rte_pause()
calls to busy-wait loops in the cnxk drivers.

The first two patches fix existing empty spinloops in the net/cnxk
and event/cnxk drivers. These were identified using a new coccinelle
script that finds variations of the pattern:

    while (!atomic(&flag));

The third patch adds this coccinelle script to devtools/ so that
similar issues can be detected and fixed automatically.

v2 - rebase for 26.07

Stephen Hemminger (3):
  net/cnxk: add pause to spinloops
  event/cnxk: add pause to spinloops
  devtools/cocci: add script to find empty spinloops

 devtools/cocci/fix_empty_spinloops.cocci | 165 +++++++++++++++++++++++
 drivers/event/cnxk/cn10k_worker.c        |   2 +-
 drivers/event/cnxk/cn20k_worker.c        |   2 +-
 drivers/event/cnxk/cnxk_tim_worker.h     |   4 +-
 drivers/net/cnxk/cn10k_tx.h              |   4 +-
 drivers/net/cnxk/cn20k_tx.h              |   4 +-
 6 files changed, 173 insertions(+), 8 deletions(-)
 create mode 100644 devtools/cocci/fix_empty_spinloops.cocci

-- 
2.53.0

