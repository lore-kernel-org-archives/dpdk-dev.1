Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDEECA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 21:32:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4691040265;
	Thu, 14 Aug 2025 23:32:53 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 4C83E400EF
 for <dev@dpdk.org>; Thu, 14 Aug 2025 23:32:52 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4c2z43491Pz3TZH;
 Thu, 14 Aug 2025 21:32:51 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4c2z430wr0z3Bm2;
 Thu, 14 Aug 2025 21:32:51 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1755207171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ql5SekLGmSLv8uq5zFHEs00FYY2Hgs1Xl0dH3Wxqr6s=;
 b=fXk+dwFwVLPk0oeQZjajvWyup9KiIHZgCO4tf70Vkoopo7znr1iKKLRjhR05nxVQp7w8De
 ZuAoO5CUf37D4Z8PeK9nYOyBNjpnKNX19+7fUlItRS8lVVcLQ4zVXk/d5WMsWC8IvW66n2
 WPN9JGVs+P6j2sfELpNU99nxxmW5gBvO0HwW5O4k8XoIFsy9AkVWQmJMSUgpVPLy73zpOH
 JNqnhXel6a2uoiJ58VJ6NvxOQHvHvK5ONrdJ7W6NZyWTz05QqAB5OiZK2T4/oCnNmqhBvR
 zw9btThA5BJEV3uqMZVJ3k1aP6oxBpiBN+Y5Xe2bLoO2YAVQK2UB27vpvr1RYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1755207171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ql5SekLGmSLv8uq5zFHEs00FYY2Hgs1Xl0dH3Wxqr6s=;
 b=D2bAEZ46y22JfmLY8VtkDc3ns6Ej89SG/pIOsXJDoVv/g/vC68UojzqQULV+KDTYF70wfN
 8CUUSna8fIeccYgz0F9bV2ZFPV9wKotRrovrgnkuWbnhGxjsgOD3feEFaZHzC31owVxbVj
 Fk+zxV4X++boPpTVPT7Fz68vtIvB7E5fKP8DFGKNCoLTTA4xdNdh1KI2O5zB6aRHZSflUV
 pZvmdCAKq82NgUlFYHPdYqQI4wib6J7bQiD5a1RhbDsshr6Sjf+DqLpseAcve9jyFrX5nb
 qkjJs8qZMuUf0DHyvbOevWZcrkrOhG76qSB+b3KnrPPHD4I135EuyCIYrQqM9g==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1755207171; a=rsa-sha256; cv=none;
 b=wXdMrYPRpgzA0YWi/kJq9vNE24Acqwb/fWt6r7M5SQD0jgVtorBEEoFmsCa1Q1+fITt4Nr
 VpqWFZbwQ9UcU7JrmL2XnyybTQL4I90OZ0Znklpv0rN9vcuEe728L/iysRYN23mw4B7XOs
 pFR/fpjDM3D6qmj57lpEqgLwyoJYogN1dFKucJKqziEnJmJUxNoiiyjGoN1nTBy/St6w8H
 wry/apX6cdd+x1mGDWK+6YQT/phjcm9UVtLAR/CSgO/Y0dgv6A4YEjB4ZKHg3HauUCn1mZ
 bK5tkNORQuUv17w+Tfh5ZqI0/mSyxZZHj/PxeK30K4oYm6nL9DrGmC7oruntMg==
Received: from s1.pct.niksun.com (70-59-118-59.mpls.qwest.net [70.59.118.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4c2z425jXvzRBS;
 Thu, 14 Aug 2025 21:32:50 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH v2 0/3] EAL memory fixes
Date: Thu, 14 Aug 2025 16:32:42 -0500
Message-ID: <20250814213246.4141803-1-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.50.1
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

Hi there,

This patchset contains a number of EAL-specific memory fixes that I've
made over the last year. Two pertain to FreeBSD, one pertains to Linux.

v2:
* Log messages are no longer split across multiple lines.
* The patch titled "Do not index out of bounds in memseg list" has been
  removed since there was no indexing out of bounds happening.
* A new patch has been added per Anatoly's recommendation that starts
  searching for memseg entries after the last used entry.

Jake Freeland (3):
  eal/freebsd: Do not use prev_ms_idx for hole detection
  eal/freebsd: Avoid claiming memseg holes
  eal/linux: Check hugepage access permissions

 lib/eal/freebsd/eal_memory.c      | 24 +++++++++++++++++++-----
 lib/eal/linux/eal_hugepage_info.c |  7 +++++++
 2 files changed, 26 insertions(+), 5 deletions(-)

--
2.47.2

