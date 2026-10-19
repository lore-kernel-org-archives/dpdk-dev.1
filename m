Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A4CCF2D3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 07:51:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74402402E8;
	Mon, 19 Oct 2026 09:51:21 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E7D4E40269
 for <dev@dpdk.org>; Mon, 19 Oct 2026 09:51:20 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BB78220678;
 Mon, 19 Oct 2026 09:51:20 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 1/3] app/crypto-perf: fix asymmetric op pool name size
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 19 Oct 2026 09:51:16 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65ABD@smartserver.smartshare.dk>
In-Reply-To: <atXLLZ90G06UWwx2@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/3] app/crypto-perf: fix asymmetric op pool name size
Thread-Index: Ad1fnjPa82iURREgSg6J1pR9sd+ovAAAD5gg
References: <20260921215733.404686-1-stephen@networkplumber.org>
 <20261016153949.2965592-1-stephen@networkplumber.org>
 <20261016153949.2965592-2-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65AB9@smartserver.smartshare.dk>
 <atXLLZ90G06UWwx2@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Monday, 19 October 2026 09.48
>=20
> On Fri, Oct 16, 2026 at 10:13:53PM +0200, Morten Br=F8rup wrote:
> > snprintf() doesn't ensure zero-terminated string.
>=20
> Actually it does. If return value is size of more, then truncation has
> occurred, and only size-1 bytes plus null have been written.

Sorry, you're right!
Got it mixed up with strncpy().

-Morten

