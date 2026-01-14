Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592E8D31A29
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 09:32:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DBA2402EA;
	Wed, 14 Jan 2026 10:32:43 +0100 (CET)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 6183C40289
 for <dev@dpdk.org>; Wed, 14 Jan 2026 10:32:42 +0100 (CET)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R12" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4drgrS6KZtz3pxK;
 Wed, 14 Jan 2026 09:32:40 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R12" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4drgrS5Ckhz3Ytw;
 Wed, 14 Jan 2026 09:32:40 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1768383160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8O+spTpYGcgT11unyciNyGE8qGTd09Juqe1t2bZudoM=;
 b=mP2UKDmFPeKL7pR8HGKdUsQVJcxFMzQ6ye4udxnCokFCQ3hvqw2Y5DTS1z8HAQxt+SEcre
 xppKBuGn3WQSMZH5vJO/SW+3oIhD2aPgPsWx1t4ekZfQbwYA5T1t+PN9rNy4iCGfzAvEIK
 HTEIebAP4JaqOfyYT0AhkKx6TVOs0iDj8loDexdfIHvUxZ/NU1zluBSRBlZAcCWNFgroWb
 UV0JQOZFnkYrDGqaM7G+h+ZAKzPFquaSs681TTPanum5dauZZ2eNx9zjB60SPOkUnNHezV
 Fjc7UEd56IYha1F0CJ68bAY9LRTh3tINIQb15HVAcpc3DoZ4CVooQxGdB9JzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1768383160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8O+spTpYGcgT11unyciNyGE8qGTd09Juqe1t2bZudoM=;
 b=EevtQFgVCIP+MLe3EljAlbtlk0UvT6n0964rLyrBgN8DnSzgLUeSGDkGh24MUgg26AzrXV
 nyCOfvYfRKXxV0FdCpgnv7fPnm7V9zh9L8iWPXfZktW5m8nwhoOg60LpHFGXD3AD9Brf86
 Jmpl+8mUauSj1O4YGmOXN9qr2jNvsQYRJKOMlomcqOfxNM2EPeSePcVfdR/blVpA1eOfbh
 Di128fVCeK5VanGAVpC7tEq/sE9lXUc7I0HJQZsujQPsLYVvWZFr/pO2f8JwfNnlIWfad7
 EyrjbCPxkh8taX5jG6vKTttZO3sXKbybQiLLG+61Nec1uV+FUz8926ziF7roHw==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1768383160; a=rsa-sha256; cv=none;
 b=J0mnjJWBVLpv9gqRyykSkwjiRxzlo8f6rfA5GPtv/jR0zFB/bFbKYs7vUDO6rVBK3L4U7R
 gteOOAMNaTqvariHbtqDfAvJ3vQcXXo7jPOIVpjAADNjCu7fUh2fN1gUoQgcJ9YJRrxYyZ
 3lXjyyBL1ocCNcY9IySHgr67a+RxXtz1+d+CW0CMzHdeeH+WVAI/qrE/yIhDTJ9dZev0OL
 zxIEkogNp0cILpsktIPN1XtM5Vk3OiCSLhQbA40km0raBrDVctFXRCM82jzyYE/Kov/OQJ
 mCaC35x4JFZCWmo8NQ9LFKtLTnr96H+vO8ikbx+zXkOIv5VDT3Ig00+oXvPHXw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from x1c.netflix.com (unknown [IPv6:2607:fb10:2023::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4drgrQ31RSzs4l;
 Wed, 14 Jan 2026 09:32:38 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH v3 0/3] EAL memory fixes
Date: Wed, 14 Jan 2026 18:31:26 +0900
Message-ID: <20260114093140.3256584-1-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250814213246.4141803-1-jfree@FreeBSD.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
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

This patchset contains a number of EAL-specific memory fixes that I've
made over the last year. Two pertain to FreeBSD, one pertains to Linux.

v2:
* Log messages are no longer split across multiple lines.
* The patch titled "Do not index out of bounds in memseg list" has been
  removed since there was no indexing out of bounds happening.
* A new patch has been added per Anatoly's recommendation that starts
  searching for memseg entries after the last used entry.

v3:
* Check if ms_idx is zero to accommodate static analysis tools.
* Remove redundant start_idx check.
* Reword hugepage skip message.

Jake Freeland (3):
  eal/freebsd: do not use prev_ms_idx for hole detection
  eal/freebsd: avoid claiming memseg holes
  eal/linux: check hugepage access permissions

 lib/eal/freebsd/eal_memory.c      | 26 +++++++++++++++++++++-----
 lib/eal/linux/eal_hugepage_info.c |  7 +++++++
 2 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.51.0

