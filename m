Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CD9E9461F
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 23:08:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02AF74027F;
	Tue, 10 Feb 2026 00:08:49 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A0C47400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 00:08:47 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 69AEA206E4;
 Tue, 10 Feb 2026 00:08:47 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v4 20/35] net/intel: write descriptors using non-volatile
 pointers
Date: Tue, 10 Feb 2026 00:08:44 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656F6@smartserver.smartshare.dk>
In-Reply-To: <20260209164538.1428499-21-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 20/35] net/intel: write descriptors using non-volatile
 pointers
Thread-Index: AdyZ4+EmByL5e0nbT4uV4L47UmEHkgAMoG4Q
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-21-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
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

> +static inline void
> +write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
> +{
> +	uint64_t *txd_qw =3D __rte_assume_aligned(RTE_CAST_PTR(void *,
> txd), 16);
> +
> +	txd_qw[0] =3D rte_cpu_to_le_64(qw0);
> +	txd_qw[1] =3D rte_cpu_to_le_64(qw1);
> +}

How about using __rte_aligned() instead, something like this (untested):

struct __rte_aligned(16) txd_t {
	uint64_t	qw0;
	uint64_t	qw1;
};

*RTE_CAST_PTR(volatile struct txd_t *, txd) =3D {
	rte_cpu_to_le_64(qw0),
	rte_cpu_to_le_64(qw1)
};


And why strip the "volatile"?

