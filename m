Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB397F89256
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 10:46:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6A374029D;
	Tue, 21 Apr 2026 12:46:22 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1B8B04027C
 for <dev@dpdk.org>; Tue, 21 Apr 2026 12:46:22 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E64B423C33;
 Tue, 21 Apr 2026 12:46:21 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: SORING cache guards
Date: Tue, 21 Apr 2026 12:46:20 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65804@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: SORING cache guards
Thread-Index: AdzRfBbKIQZtp6pOSG+41lT5h3+gfg==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
	<dev@dpdk.org>
Cc: "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>
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

Konstantin,

Suggestion:

I'm not sure about this, but shouldn't the arrays in the SORING be =
padded by cache guards?

/*
 * Calculate size offsets for SORING internal data layout.
 */
static size_t
soring_get_szofs(uint32_t esize, uint32_t msize, uint32_t count,
	uint32_t stages, size_t *elst_ofs, size_t *state_ofs,
	size_t *stage_ofs)
{
	size_t sz;
	const struct rte_soring * const r =3D NULL;

	sz =3D sizeof(r[0]) + (size_t)count * esize;
	sz =3D RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);
+	sz +=3D RTE_CACHE_GUARD_LINES * RTE_CACHE_LINE_SIZE;

	if (elst_ofs !=3D NULL)
		*elst_ofs =3D sz;

-	sz =3D sz + (size_t)count * msize;
+	sz +=3D (size_t)count * msize;
	sz =3D RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);
+	sz +=3D RTE_CACHE_GUARD_LINES * RTE_CACHE_LINE_SIZE;

	if (state_ofs !=3D NULL)
		*state_ofs =3D sz;

	sz +=3D sizeof(r->state[0]) * count;
	sz =3D RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);
+	sz +=3D RTE_CACHE_GUARD_LINES * RTE_CACHE_LINE_SIZE;

	if (stage_ofs !=3D NULL)
		*stage_ofs =3D sz;

	sz +=3D sizeof(r->stage[0]) * stages;
	sz =3D RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);
+	sz +=3D RTE_CACHE_GUARD_LINES * RTE_CACHE_LINE_SIZE;

	return sz;
}

Such a change would break the ABI, so it should be announced in advance.

I'll leave it up to you to provide patches, if you agree. ;-)

-Morten

