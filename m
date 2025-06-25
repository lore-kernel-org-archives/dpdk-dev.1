Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5367C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 05:51:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F1824060F;
	Thu, 26 Jun 2025 07:51:56 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1B53D400D7
 for <dev@dpdk.org>; Thu, 26 Jun 2025 07:51:55 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F21D7210FD
 for <dev@dpdk.org>; Thu, 26 Jun 2025 07:51:53 +0200 (CEST)
Received: from mail pickup service by smartserver.smartsharesystems.com with
 Microsoft SMTPSVC; Thu, 26 Jun 2025 07:52:00 +0200
Subject: Function to fail at build time?
Date: Thu, 26 Jun 2025 01:55:02 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD40@smartserver.smartshare.dk>
X-MS-Has-Attach: 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-MS-TNEF-Correlator: 
Thread-Topic: Function to fail at build time?
Thread-Index: AdvmLJEdF/MHwkB4SbqV449q9g4lYQ==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
To: <dev@dpdk.org>
X-GRP-TAN: SMARTSERVER@2B3BA4BFB6F244A2AE2A7C8E0BF9E15F
X-OriginalArrivalTime: 26 Jun 2025 05:52:00.0593 (UTC)
 FILETIME=[6F48FC10:01DBE65E]
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

I was wondering if this was somehow possible:

#define RTE_VERIFY(exp) do { \
+	if (__rte_constant(exp)) \
+		FAIL_AT_BUILD_TIME(); \
	if (unlikely(!(exp))) \
		rte_panic("line %d\tassert \"%s\" failed\n", __LINE__, #exp); \
} while (0)

I tried static_assert(), but it cannot be used in this way.

-Morten

