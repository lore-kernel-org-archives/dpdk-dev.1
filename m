Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD07CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 14:26:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 100384029A;
	Fri, 22 Aug 2025 16:26:07 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3BF2740297
 for <dev@dpdk.org>; Fri, 22 Aug 2025 16:26:06 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E334A209AA;
 Fri, 22 Aug 2025 16:26:05 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH v6 1/3] mbuf: de-inline sanity checking a reinitialized
 mbuf
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Fri, 22 Aug 2025 16:26:04 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE62@smartserver.smartshare.dk>
In-Reply-To: <20250822124731.20633-2-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [PATCH v6 1/3] mbuf: de-inline sanity checking a reinitialized
 mbuf
Thread-Index: AdwTYvGgcW50SbNjRpmkcyNYk/HyUAADYHEw
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250822124731.20633-1-mb@smartsharesystems.com>
 <20250822124731.20633-2-mb@smartsharesystems.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>
Cc: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
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

Rm9yZ290IHRvIGFkZCB0aGUgQUNLcyBmcm9tIHByZXZpb3VzIHZlcnNpb24gb2YgdGhpcyBwYXRj
aDoNCkFja2VkLWJ5OiBBbmRyZXcgUnliY2hlbmtvIDxhbmRyZXcucnliY2hlbmtvQG9rdGV0bGFi
cy5ydT4NCkFja2VkLWJ5OiBLb25zdGFudGluIEFuYW55ZXYgPGtvbnN0YW50aW4uYW5hbnlldkBo
dWF3ZWkuY29tPg0KDQotTW9ydGVuDQoNCg==
