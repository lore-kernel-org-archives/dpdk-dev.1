Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FC2CFD376
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 10:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 460E54013F;
	Fri, 28 Nov 2025 11:50:22 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9A901400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 11:50:20 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7E1A920698
 for <dev@dpdk.org>; Fri, 28 Nov 2025 11:50:19 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] mbuf: fix packet copy
Date: Fri, 28 Nov 2025 11:50:18 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6559D@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mbuf: fix packet copy
Thread-Index: AdxZTJorOUhx0EXzTH2tsl7JhzajBgD+mq2gAMNuIRA=
References: <20251119120403.907511-1-mb@smartsharesystems.com> 
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>
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

UmVjaGVjay1yZXF1ZXN0OiBpb2wtY29tcGlsZS1hbWQ2NC10ZXN0aW5nDQoNCg==
