Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3096C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 15:31:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 141B5402CC;
	Fri, 21 Feb 2025 16:31:31 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 31DCC402BB
 for <dev@dpdk.org>; Fri, 21 Feb 2025 16:31:30 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E8758206C7;
 Fri, 21 Feb 2025 16:31:29 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v4 01/10] eal: add workaround for __builtin_constant_p
Date: Fri, 21 Feb 2025 16:31:28 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FA62@smartserver.smartshare.dk>
In-Reply-To: <1740087064-18680-2-git-send-email-andremue@linux.microsoft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 01/10] eal: add workaround for __builtin_constant_p
Thread-Index: AduD3tQ3ZqgT2ANWTY2Pl4HWLRvCqAAloSpQ
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740087064-18680-1-git-send-email-andremue@linux.microsoft.com>
 <1740087064-18680-2-git-send-email-andremue@linux.microsoft.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Andre Muezerie" <andremue@linux.microsoft.com>
Cc: <dev@dpdk.org>,
	"Chengwen Feng" <fengchengwen@huawei.com>
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

Thank you for this updated MSVC variant of the macro, and its detailed =
description.

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

