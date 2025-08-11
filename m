Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D17CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 15:20:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDFEB402AC;
	Mon, 11 Aug 2025 17:20:15 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 9894C400D7
 for <dev@dpdk.org>; Mon, 11 Aug 2025 17:20:14 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-459e7ea3ebeso16986655e9.0
 for <dev@dpdk.org>; Mon, 11 Aug 2025 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754925614;
 x=1755530414; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qO9SAkPDpLZMXhL68uaITrf4SyaeWtzcYoSK1yAJZAY=;
 b=iy40tZLgXimNzXKnXx/JHc6AUnq8mh+Myb98qYArYX3Wx7fqreh2bKuEOQOc7NgMRA
 yMAT+jKEBPAoazJyy1PY6uKvBdeQUJd/gRevkpn0BdVuD9jx/PyGhbQ+8JfzaH/OaVFv
 Ry2nEoCwTur1TR6jt+yWfsNTPpCOQGl6YReEyT/TGH8muKGo2yUtHdfpAWesm0TI1P7d
 Bx1Fy5w8rad/BqGlzfeQdGCBCuJhCeG8ZJxquOCf1o0KMeZdD5wXkZr1PoYiPMKtaS12
 saL9opwDvXyqKDOmej41TBHNgEVCX3wlAwkuQN5/vZztqheymYn2nhO8X5eMffVGytfr
 GTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754925614; x=1755530414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qO9SAkPDpLZMXhL68uaITrf4SyaeWtzcYoSK1yAJZAY=;
 b=xIMAw/nS/XccwxMOpcEAQ1wpR1xaMS/FoblRziGCSdYD9KDYTqgeW2kWPpng8ScZ7V
 ZjkNbafLFrigskiO0SZbIxBEfM0Z2eA6AxjU66FVMTRUL26dvYICJ74rQ3x6CKjkjVaA
 +jvPZCd40bOI59Y85JNLYsfBGjKWajuvykybSc4lWAviGxQ6FtcoWynGXP/SaK7gNln6
 YPyCQ3g4OLZ1JmGkfEx6Wc9BI8pnP68DrBWhpHb//ZRiPH6GkplhJfTVmp7NvJKawUfo
 VRcyt8fJ8nSDLtrf79zvPp3xc2qoRjn5OaxOh/W+mbDXE6BuI9OGPrXEgyg1xNiUF37Y
 72sA==
X-Gm-Message-State: AOJu0YzaL4VNbAxPmc2IeI8QlB6P1Qim3pUtemnrmiKmW+5GBiMrDpCP
 T+Zt4hC9mthisKMeU4YJjIiC+CXtguAGvIeva1eEnHyh6FRDXlXwiSM8RVn/xuEs+vo=
X-Gm-Gg: ASbGncvOvxYtPt8QFoqtEPo+l03xBd+aD8VQFp3UXd/nEmDz2akv48SGMVTG9dsDzu4
 FI+94KPLm4wzAdfLifsA4LPfry2cl90fPPqMqFt6NxIEoWGv4ZSERcsvSsGFLhMaleeWrRxfTkA
 6LX1fRcRIK4Lp7Fs/jeF56GZkk7ZdGgsG5aHgTkBcZxN8Yn4TT4N+f8TDMaawmKA5IokSHfqEy3
 m8w2tzgOwNvziRelqxhW/uJyuZb9+0+dIZ5QrZOjFhaCR+LAtopaJe4JIbRzjKk2jKwnXH3P2dp
 pdSsgeyHHy1j40K+KD4XSuQy0Tr9Qg6jSCJf5jtEIdMRdMSq34pGjH9py0LHMK6aN1ZXDAgQXFw
 uuNjJZFfNVltYt67mDyjoengjWYEcvyZ2YwS9MQt5X+OlAkA6ecJlfJvPC3OxxxH7XGk4aT4HQk
 8=
X-Google-Smtp-Source: AGHT+IF2UQt8cRfpKPHTPoILCOcNAVRyXnD/Rc24tJXuYP3q6cKVxDbO+xgRepcPsrfSpu2E8rW6bw==
X-Received: by 2002:a05:600c:1c12:b0:456:29ae:3dbe with SMTP id
 5b1f17b1804b1-45a10c001b5mr753995e9.24.1754925613862; 
 Mon, 11 Aug 2025 08:20:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a053a9019sm73062045e9.21.2025.08.11.08.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:20:13 -0700 (PDT)
Date: Mon, 11 Aug 2025 08:20:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Akhil Goyal" <gakhil@marvell.com>, "Fan Zhang" <fanzhang.oss@gmail.com>
Subject: Re: [PATCH v12 01/10] mbuf: replace term sanity check
Message-ID: <20250811082008.62686282@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE20@smartserver.smartshare.dk>
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
 <20250402232441.440346-2-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE20@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 11 Aug 2025 11:55:31 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Thursday, 3 April 2025 01.23
> >=20
> > Replace rte_mbuf_sanity_check() with rte_mbuf_verify()
> > to match the similar macro RTE_VERIFY() in rte_debug.h
> >=20
> > The term sanity check is on the Tier 2 list of words
> > that should be replaced.
> >=20
> > For this release keep old API functions but mark them
> > as deprecated.
> >=20
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> > Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > ---
> >  app/test/test_cryptodev.c            |  2 +-
> >  app/test/test_mbuf.c                 | 28 +++++-----
> >  doc/guides/prog_guide/mbuf_lib.rst   |  4 +-
> >  doc/guides/rel_notes/deprecation.rst |  3 ++
> >  lib/mbuf/rte_mbuf.c                  | 23 +++++---
> >  lib/mbuf/rte_mbuf.h                  | 79 +++++++++++++++-------------
> >  lib/mbuf/version.map                 |  1 +
> >  7 files changed, 79 insertions(+), 61 deletions(-)
> >=20
> > diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
> > index 31a4905a97..d5f3843daf 100644
> > --- a/app/test/test_cryptodev.c
> > +++ b/app/test/test_cryptodev.c
> > @@ -264,7 +264,7 @@ create_mbuf_from_heap(int pkt_len, uint8_t pattern)
> >  	m->port =3D RTE_MBUF_PORT_INVALID;
> >  	m->buf_len =3D MBUF_SIZE - sizeof(struct rte_mbuf) - RTE_PKTMBUF_HEAD=
ROOM;
> >  	rte_pktmbuf_reset_headroom(m);
> > -	__rte_mbuf_sanity_check(m, 1);
> > +	__rte_mbuf_verify(m, 1);
> >=20
> >  	m->buf_addr =3D (char *)m + sizeof(struct rte_mbuf) +
> > RTE_PKTMBUF_HEADROOM;
> >=20
> > diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
> > index 17be977f31..3fbb5dea8b 100644
> > --- a/app/test/test_mbuf.c
> > +++ b/app/test/test_mbuf.c
> > @@ -262,8 +262,8 @@ test_one_pktmbuf(struct rte_mempool *pktmbuf_pool)
> >  		GOTO_FAIL("Buffer should be continuous");
> >  	memset(hdr, 0x55, MBUF_TEST_HDR2_LEN);
> >=20
> > -	rte_mbuf_sanity_check(m, 1);
> > -	rte_mbuf_sanity_check(m, 0);
> > +	rte_mbuf_verify(m, 1);
> > +	rte_mbuf_verify(m, 0);
> >  	rte_pktmbuf_dump(stdout, m, 0);
> >=20
> >  	/* this prepend should fail */
> > @@ -1162,7 +1162,7 @@ test_refcnt_mbuf(void)
> >=20
> >  #ifdef RTE_EXEC_ENV_WINDOWS
> >  static int
> > -test_failing_mbuf_sanity_check(struct rte_mempool *pktmbuf_pool)
> > +test_failing_mbuf_verify(struct rte_mempool *pktmbuf_pool)
> >  {
> >  	RTE_SET_USED(pktmbuf_pool);
> >  	return TEST_SKIPPED;
> > @@ -1181,12 +1181,12 @@ mbuf_check_pass(struct rte_mbuf *buf)
> >  }
> >=20
> >  static int
> > -test_failing_mbuf_sanity_check(struct rte_mempool *pktmbuf_pool)
> > +test_failing_mbuf_verify(struct rte_mempool *pktmbuf_pool)
> >  {
> >  	struct rte_mbuf *buf;
> >  	struct rte_mbuf badbuf;
> >=20
> > -	printf("Checking rte_mbuf_sanity_check for failure conditions\n");
> > +	printf("Checking rte_mbuf_verify for failure conditions\n");
> >=20
> >  	/* get a good mbuf to use to make copies */
> >  	buf =3D rte_pktmbuf_alloc(pktmbuf_pool);
> > @@ -1708,7 +1708,7 @@ test_mbuf_validate_tx_offload(const char *test_na=
me,
> >  		GOTO_FAIL("%s: mbuf allocation failed!\n", __func__);
> >  	if (rte_pktmbuf_pkt_len(m) !=3D 0)
> >  		GOTO_FAIL("%s: Bad packet length\n", __func__);
> > -	rte_mbuf_sanity_check(m, 0);
> > +	rte_mbuf_verify(m, 0);
> >  	m->ol_flags =3D ol_flags;
> >  	m->tso_segsz =3D segsize;
> >  	ret =3D rte_validate_tx_offload(m);
> > @@ -1915,7 +1915,7 @@ test_pktmbuf_read(struct rte_mempool *pktmbuf_poo=
l)
> >  		GOTO_FAIL("%s: mbuf allocation failed!\n", __func__);
> >  	if (rte_pktmbuf_pkt_len(m) !=3D 0)
> >  		GOTO_FAIL("%s: Bad packet length\n", __func__);
> > -	rte_mbuf_sanity_check(m, 0);
> > +	rte_mbuf_verify(m, 0);
> >=20
> >  	data =3D rte_pktmbuf_append(m, MBUF_TEST_DATA_LEN2);
> >  	if (data =3D=3D NULL)
> > @@ -1964,7 +1964,7 @@ test_pktmbuf_read_from_offset(struct rte_mempool
> > *pktmbuf_pool)
> >=20
> >  	if (rte_pktmbuf_pkt_len(m) !=3D 0)
> >  		GOTO_FAIL("%s: Bad packet length\n", __func__);
> > -	rte_mbuf_sanity_check(m, 0);
> > +	rte_mbuf_verify(m, 0);
> >=20
> >  	/* prepend an ethernet header */
> >  	hdr =3D (struct ether_hdr *)rte_pktmbuf_prepend(m, hdr_len);
> > @@ -2109,7 +2109,7 @@ create_packet(struct rte_mempool *pktmbuf_pool,
> >  			GOTO_FAIL("%s: mbuf allocation failed!\n", __func__);
> >  		if (rte_pktmbuf_pkt_len(pkt_seg) !=3D 0)
> >  			GOTO_FAIL("%s: Bad packet length\n", __func__);
> > -		rte_mbuf_sanity_check(pkt_seg, 0);
> > +		rte_mbuf_verify(pkt_seg, 0);
> >  		/* Add header only for the first segment */
> >  		if (test_data->flags =3D=3D MBUF_HEADER && seg =3D=3D 0) {
> >  			hdr_len =3D sizeof(struct rte_ether_hdr);
> > @@ -2321,7 +2321,7 @@ test_pktmbuf_ext_shinfo_init_helper(struct rte_me=
mpool
> > *pktmbuf_pool)
> >  		GOTO_FAIL("%s: mbuf allocation failed!\n", __func__);
> >  	if (rte_pktmbuf_pkt_len(m) !=3D 0)
> >  		GOTO_FAIL("%s: Bad packet length\n", __func__);
> > -	rte_mbuf_sanity_check(m, 0);
> > +	rte_mbuf_verify(m, 0);
> >=20
> >  	ext_buf_addr =3D rte_malloc("External buffer", buf_len,
> >  			RTE_CACHE_LINE_SIZE);
> > @@ -2482,8 +2482,8 @@ test_pktmbuf_ext_pinned_buffer(struct rte_mempool
> > *std_pool)
> >  		GOTO_FAIL("%s: test_pktmbuf_copy(pinned) failed\n",
> >  			  __func__);
> >=20
> > -	if (test_failing_mbuf_sanity_check(pinned_pool) < 0)
> > -		GOTO_FAIL("%s: test_failing_mbuf_sanity_check(pinned)"
> > +	if (test_failing_mbuf_verify(pinned_pool) < 0)
> > +		GOTO_FAIL("%s: test_failing_mbuf_verify(pinned)"
> >  			  " failed\n", __func__);
> >=20
> >  	if (test_mbuf_linearize_check(pinned_pool) < 0)
> > @@ -2857,8 +2857,8 @@ test_mbuf(void)
> >  		goto err;
> >  	}
> >=20
> > -	if (test_failing_mbuf_sanity_check(pktmbuf_pool) < 0) {
> > -		printf("test_failing_mbuf_sanity_check() failed\n");
> > +	if (test_failing_mbuf_verify(pktmbuf_pool) < 0) {
> > +		printf("test_failing_mbuf_verify() failed\n");
> >  		goto err;
> >  	}
> >=20
> > diff --git a/doc/guides/prog_guide/mbuf_lib.rst
> > b/doc/guides/prog_guide/mbuf_lib.rst
> > index 4ad2a21f3f..6c96931f8c 100644
> > --- a/doc/guides/prog_guide/mbuf_lib.rst
> > +++ b/doc/guides/prog_guide/mbuf_lib.rst
> > @@ -266,8 +266,8 @@ can be found in several of the sample applications,=
 for
> > example, the IPv4 Multic
> >  Debug
> >  -----
> >=20
> > -In debug mode, the functions of the mbuf library perform sanity checks=
 before
> > any operation (such as, buffer corruption,
> > -bad type, and so on).
> > +In debug mode, the functions of the mbuf library perform consistency c=
hecks
> > +before any operation (such as, buffer corruption, bad type, and so on).
> >=20
> >  Use Cases
> >  ---------
> > diff --git a/doc/guides/rel_notes/deprecation.rst
> > b/doc/guides/rel_notes/deprecation.rst
> > index 36489f6e68..10bb08a634 100644
> > --- a/doc/guides/rel_notes/deprecation.rst
> > +++ b/doc/guides/rel_notes/deprecation.rst
> > @@ -142,3 +142,6 @@ Deprecation Notices
> >  * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
> >    ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
> >    Those API functions are used internally by DPDK core and netvsc PMD.
> > +
> > +* mbuf: The function ``rte_mbuf_sanity_check`` is deprecated.
> > +  Use the new function ``rte_mbuf_verify`` instead.
> > diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
> > index 559d5ad8a7..fc5d4ba29d 100644
> > --- a/lib/mbuf/rte_mbuf.c
> > +++ b/lib/mbuf/rte_mbuf.c
> > @@ -367,9 +367,9 @@ rte_pktmbuf_pool_create_extbuf(const char *name, un=
signed
> > int n,
> >  	return mp;
> >  }
> >=20
> > -/* do some sanity checks on a mbuf: panic if it fails */
> > +/* do some checks on a mbuf: panic if it fails */
> >  void
> > -rte_mbuf_sanity_check(const struct rte_mbuf *m, int is_header)
> > +rte_mbuf_verify(const struct rte_mbuf *m, int is_header)
> >  {
> >  	const char *reason;
> >=20
> > @@ -377,6 +377,13 @@ rte_mbuf_sanity_check(const struct rte_mbuf *m, int
> > is_header)
> >  		rte_panic("%s\n", reason);
> >  }
> >=20
> > +/* For ABI compatibility, to be removed in next release */
> > +void
> > +rte_mbuf_sanity_check(const struct rte_mbuf *m, int is_header)
> > +{
> > +	rte_mbuf_verify(m, is_header);
> > +}
> > +
> >  int rte_mbuf_check(const struct rte_mbuf *m, int is_header,
> >  		   const char **reason)
> >  {
> > @@ -496,7 +503,7 @@ void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs,
> > unsigned int count)
> >  		if (unlikely(m =3D=3D NULL))
> >  			continue;
> >=20
> > -		__rte_mbuf_sanity_check(m, 1);
> > +		__rte_mbuf_verify(m, 1);
> >=20
> >  		do {
> >  			m_next =3D m->next;
> > @@ -546,7 +553,7 @@ rte_pktmbuf_clone(struct rte_mbuf *md, struct rte_m=
empool
> > *mp)
> >  		return NULL;
> >  	}
> >=20
> > -	__rte_mbuf_sanity_check(mc, 1);
> > +	__rte_mbuf_verify(mc, 1);
> >  	return mc;
> >  }
> >=20
> > @@ -596,7 +603,7 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct
> > rte_mempool *mp,
> >  	struct rte_mbuf *mc, *m_last, **prev;
> >=20
> >  	/* garbage in check */
> > -	__rte_mbuf_sanity_check(m, 1);
> > +	__rte_mbuf_verify(m, 1);
> >=20
> >  	/* check for request to copy at offset past end of mbuf */
> >  	if (unlikely(off >=3D m->pkt_len))
> > @@ -660,7 +667,7 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct
> > rte_mempool *mp,
> >  	}
> >=20
> >  	/* garbage out check */
> > -	__rte_mbuf_sanity_check(mc, 1);
> > +	__rte_mbuf_verify(mc, 1);
> >  	return mc;
> >  }
> >=20
> > @@ -671,7 +678,7 @@ rte_pktmbuf_dump(FILE *f, const struct rte_mbuf *m,
> > unsigned dump_len)
> >  	unsigned int len;
> >  	unsigned int nb_segs;
> >=20
> > -	__rte_mbuf_sanity_check(m, 1);
> > +	__rte_mbuf_verify(m, 1);
> >=20
> >  	fprintf(f, "dump mbuf at %p, iova=3D%#" PRIx64 ", buf_len=3D%u\n", m,
> > rte_mbuf_iova_get(m),
> >  		m->buf_len);
> > @@ -689,7 +696,7 @@ rte_pktmbuf_dump(FILE *f, const struct rte_mbuf *m,
> > unsigned dump_len)
> >  	nb_segs =3D m->nb_segs;
> >=20
> >  	while (m && nb_segs !=3D 0) {
> > -		__rte_mbuf_sanity_check(m, 0);
> > +		__rte_mbuf_verify(m, 0);
> >=20
> >  		fprintf(f, "  segment at %p, data=3D%p, len=3D%u, off=3D%u,
> > refcnt=3D%u\n",
> >  			m, rte_pktmbuf_mtod(m, void *),
> > diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
> > index 06ab7502a5..53a837e4d5 100644
> > --- a/lib/mbuf/rte_mbuf.h
> > +++ b/lib/mbuf/rte_mbuf.h
> > @@ -339,16 +339,20 @@ rte_pktmbuf_priv_flags(struct rte_mempool *mp)
> >=20
> >  #ifdef RTE_LIBRTE_MBUF_DEBUG
> >=20
> > -/**  check mbuf type in debug mode */
> > -#define __rte_mbuf_sanity_check(m, is_h) rte_mbuf_sanity_check(m, is_h)
> > +/**  do mbuf type in debug mode */
> > +#define __rte_mbuf_verify(m, is_h) rte_mbuf_verify(m, is_h)
> >=20
> >  #else /*  RTE_LIBRTE_MBUF_DEBUG */
> >=20
> > -/**  check mbuf type in debug mode */
> > -#define __rte_mbuf_sanity_check(m, is_h) do { } while (0)
> > +/**  ignore mbuf checks if not in debug mode */
> > +#define __rte_mbuf_verify(m, is_h) do { } while (0)
> >=20
> >  #endif /*  RTE_LIBRTE_MBUF_DEBUG */
> >=20
> > +/* deprecated version of the macro */
> > +#define __rte_mbuf_sanity_check(m, is_h)
> > RTE_DEPRECATED(__rte_mbuf_sanity_check) \
> > +		__rte_mbuf_verify(m, is_h)
> > +
> >  #ifdef RTE_MBUF_REFCNT_ATOMIC
> >=20
> >  /**
> > @@ -514,10 +518,9 @@ rte_mbuf_ext_refcnt_update(struct
> > rte_mbuf_ext_shared_info *shinfo,
> >=20
> >=20
> >  /**
> > - * Sanity checks on an mbuf.
> > + * Check that the mbuf is valid and panic if corrupted.
> >   *
> > - * Check the consistency of the given mbuf. The function will cause a
> > - * panic if corruption is detected.
> > + * Acts assertion that mbuf is consistent. If not it calls rte_panic().
> >   *
> >   * @param m
> >   *   The mbuf to be checked.
> > @@ -526,13 +529,17 @@ rte_mbuf_ext_refcnt_update(struct
> > rte_mbuf_ext_shared_info *shinfo,
> >   *   of a packet (in this case, some fields like nb_segs are not check=
ed)
> >   */
> >  void
> > +rte_mbuf_verify(const struct rte_mbuf *m, int is_header);
> > +
> > +__rte_deprecated
> > +void
> >  rte_mbuf_sanity_check(const struct rte_mbuf *m, int is_header);
> >=20
> >  /**
> > - * Sanity checks on a mbuf.
> > + * Do consistency checks on a mbuf.
> >   *
> > - * Almost like rte_mbuf_sanity_check(), but this function gives the re=
ason
> > - * if corruption is detected rather than panic.
> > + * Check the consistency of the given mbuf and if not valid
> > + * return the reason.
> >   *
> >   * @param m
> >   *   The mbuf to be checked.
> > @@ -551,7 +558,7 @@ int rte_mbuf_check(const struct rte_mbuf *m, int
> > is_header,
> >  		   const char **reason);
> >=20
> >  /**
> > - * Sanity checks on a reinitialized mbuf in debug mode.
> > + * Do checks on a reinitialized mbuf in debug mode.
> >   *
> >   * Check the consistency of the given reinitialized mbuf.
> >   * The function will cause a panic if corruption is detected.
> > @@ -563,7 +570,7 @@ int rte_mbuf_check(const struct rte_mbuf *m, int
> > is_header,
> >   *   The mbuf to be checked.
> >   */
> >  static __rte_always_inline void
> > -__rte_mbuf_raw_sanity_check(__rte_unused const struct rte_mbuf *m)
> > +__rte_mbuf_raw_verify(__rte_unused const struct rte_mbuf *m)
> >  {
> >  	RTE_ASSERT(rte_mbuf_refcnt_read(m) =3D=3D 1);
> >  	RTE_ASSERT(m->next =3D=3D NULL);
> > @@ -572,11 +579,11 @@ __rte_mbuf_raw_sanity_check(__rte_unused const st=
ruct
> > rte_mbuf *m)
> >  	RTE_ASSERT(!RTE_MBUF_HAS_EXTBUF(m) ||
> >  			(RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> >  			rte_mbuf_ext_refcnt_read(m->shinfo) =3D=3D 1));
> > -	__rte_mbuf_sanity_check(m, 0);
> > +	__rte_mbuf_verify(m, 0);
> >  }
> >=20
> >  /** For backwards compatibility. */
> > -#define MBUF_RAW_ALLOC_CHECK(m) __rte_mbuf_raw_sanity_check(m)
> > +#define MBUF_RAW_ALLOC_CHECK(m) __rte_mbuf_raw_verify(m)
> >=20
> >  /**
> >   * Allocate an uninitialized mbuf from mempool *mp*.
> > @@ -606,7 +613,7 @@ static inline struct rte_mbuf *rte_mbuf_raw_alloc(s=
truct
> > rte_mempool *mp)
> >=20
> >  	if (rte_mempool_get(mp, &ret.ptr) < 0)
> >  		return NULL;
> > -	__rte_mbuf_raw_sanity_check(ret.m);
> > +	__rte_mbuf_raw_verify(ret.m);
> >  	return ret.m;
> >  }
> >=20
> > @@ -644,7 +651,7 @@ rte_mbuf_raw_alloc_bulk(struct rte_mempool *mp, str=
uct
> > rte_mbuf **mbufs, unsigne
> >  	int rc =3D rte_mempool_get_bulk(mp, (void **)mbufs, count);
> >  	if (likely(rc =3D=3D 0))
> >  		for (unsigned int idx =3D 0; idx < count; idx++)
> > -			__rte_mbuf_raw_sanity_check(mbufs[idx]);
> > +			__rte_mbuf_raw_verify(mbufs[idx]);
> >  	return rc;
> >  }
> >=20
> > @@ -665,7 +672,7 @@ rte_mbuf_raw_alloc_bulk(struct rte_mempool *mp, str=
uct
> > rte_mbuf **mbufs, unsigne
> >  static __rte_always_inline void
> >  rte_mbuf_raw_free(struct rte_mbuf *m)
> >  {
> > -	__rte_mbuf_raw_sanity_check(m);
> > +	__rte_mbuf_raw_verify(m);
> >  	rte_mempool_put(m->pool, m);
> >  }
> >=20
> > @@ -700,7 +707,7 @@ rte_mbuf_raw_free_bulk(struct rte_mempool *mp, stru=
ct
> > rte_mbuf **mbufs, unsigned
> >  		const struct rte_mbuf *m =3D mbufs[idx];
> >  		RTE_ASSERT(m !=3D NULL);
> >  		RTE_ASSERT(m->pool =3D=3D mp);
> > -		__rte_mbuf_raw_sanity_check(m);
> > +		__rte_mbuf_raw_verify(m);
> >  	}
> >=20
> >  	rte_mempool_put_bulk(mp, (void **)mbufs, count);
> > @@ -965,7 +972,7 @@ static inline void rte_pktmbuf_reset(struct rte_mbu=
f *m)
> >  	rte_pktmbuf_reset_headroom(m);
> >=20
> >  	m->data_len =3D 0;
> > -	__rte_mbuf_sanity_check(m, 1);
> > +	__rte_mbuf_verify(m, 1);
> >  }
> >=20
> >  /**
> > @@ -1021,22 +1028,22 @@ static inline int rte_pktmbuf_alloc_bulk(struct
> > rte_mempool *pool,
> >  	switch (count % 4) {
> >  	case 0:
> >  		while (idx !=3D count) {
> > -			__rte_mbuf_raw_sanity_check(mbufs[idx]);
> > +			__rte_mbuf_raw_verify(mbufs[idx]);
> >  			rte_pktmbuf_reset(mbufs[idx]);
> >  			idx++;
> >  			/* fall-through */
> >  	case 3:
> > -			__rte_mbuf_raw_sanity_check(mbufs[idx]);
> > +			__rte_mbuf_raw_verify(mbufs[idx]);
> >  			rte_pktmbuf_reset(mbufs[idx]);
> >  			idx++;
> >  			/* fall-through */
> >  	case 2:
> > -			__rte_mbuf_raw_sanity_check(mbufs[idx]);
> > +			__rte_mbuf_raw_verify(mbufs[idx]);
> >  			rte_pktmbuf_reset(mbufs[idx]);
> >  			idx++;
> >  			/* fall-through */
> >  	case 1:
> > -			__rte_mbuf_raw_sanity_check(mbufs[idx]);
> > +			__rte_mbuf_raw_verify(mbufs[idx]);
> >  			rte_pktmbuf_reset(mbufs[idx]);
> >  			idx++;
> >  			/* fall-through */
> > @@ -1267,8 +1274,8 @@ static inline void rte_pktmbuf_attach(struct rte_=
mbuf
> > *mi, struct rte_mbuf *m)
> >  	mi->pkt_len =3D mi->data_len;
> >  	mi->nb_segs =3D 1;
> >=20
> > -	__rte_mbuf_sanity_check(mi, 1);
> > -	__rte_mbuf_sanity_check(m, 0);
> > +	__rte_mbuf_verify(mi, 1);
> > +	__rte_mbuf_verify(m, 0);
> >  }
> >=20
> >  /**
> > @@ -1423,7 +1430,7 @@ static inline int
> > __rte_pktmbuf_pinned_extbuf_decref(struct rte_mbuf *m)
> >  static __rte_always_inline struct rte_mbuf *
> >  rte_pktmbuf_prefree_seg(struct rte_mbuf *m)
> >  {
> > -	__rte_mbuf_sanity_check(m, 0);
> > +	__rte_mbuf_verify(m, 0);
> >=20
> >  	if (likely(rte_mbuf_refcnt_read(m) =3D=3D 1)) {
> >=20
> > @@ -1494,7 +1501,7 @@ static inline void rte_pktmbuf_free(struct rte_mb=
uf *m)
> >  	struct rte_mbuf *m_next;
> >=20
> >  	if (m !=3D NULL)
> > -		__rte_mbuf_sanity_check(m, 1);
> > +		__rte_mbuf_verify(m, 1);
> >=20
> >  	while (m !=3D NULL) {
> >  		m_next =3D m->next;
> > @@ -1575,7 +1582,7 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct
> > rte_mempool *mp,
> >   */
> >  static inline void rte_pktmbuf_refcnt_update(struct rte_mbuf *m, int16=
_t v)
> >  {
> > -	__rte_mbuf_sanity_check(m, 1);
> > +	__rte_mbuf_verify(m, 1);
> >=20
> >  	do {
> >  		rte_mbuf_refcnt_update(m, v);
> > @@ -1592,7 +1599,7 @@ static inline void rte_pktmbuf_refcnt_update(stru=
ct
> > rte_mbuf *m, int16_t v)
> >   */
> >  static inline uint16_t rte_pktmbuf_headroom(const struct rte_mbuf *m)
> >  {
> > -	__rte_mbuf_sanity_check(m, 0);
> > +	__rte_mbuf_verify(m, 0);
> >  	return m->data_off;
> >  }
> >=20
> > @@ -1606,7 +1613,7 @@ static inline uint16_t rte_pktmbuf_headroom(const=
 struct
> > rte_mbuf *m)
> >   */
> >  static inline uint16_t rte_pktmbuf_tailroom(const struct rte_mbuf *m)
> >  {
> > -	__rte_mbuf_sanity_check(m, 0);
> > +	__rte_mbuf_verify(m, 0);
> >  	return (uint16_t)(m->buf_len - rte_pktmbuf_headroom(m) -
> >  			  m->data_len);
> >  }
> > @@ -1621,7 +1628,7 @@ static inline uint16_t rte_pktmbuf_tailroom(const=
 struct
> > rte_mbuf *m)
> >   */
> >  static inline struct rte_mbuf *rte_pktmbuf_lastseg(struct rte_mbuf *m)
> >  {
> > -	__rte_mbuf_sanity_check(m, 1);
> > +	__rte_mbuf_verify(m, 1);
> >  	while (m->next !=3D NULL)
> >  		m =3D m->next;
> >  	return m;
> > @@ -1665,7 +1672,7 @@ static inline struct rte_mbuf
> > *rte_pktmbuf_lastseg(struct rte_mbuf *m)
> >  static inline char *rte_pktmbuf_prepend(struct rte_mbuf *m,
> >  					uint16_t len)
> >  {
> > -	__rte_mbuf_sanity_check(m, 1);
> > +	__rte_mbuf_verify(m, 1);
> >=20
> >  	if (unlikely(len > rte_pktmbuf_headroom(m)))
> >  		return NULL;
> > @@ -1700,7 +1707,7 @@ static inline char *rte_pktmbuf_append(struct rte=
_mbuf
> > *m, uint16_t len)
> >  	void *tail;
> >  	struct rte_mbuf *m_last;
> >=20
> > -	__rte_mbuf_sanity_check(m, 1);
> > +	__rte_mbuf_verify(m, 1);
> >=20
> >  	m_last =3D rte_pktmbuf_lastseg(m);
> >  	if (unlikely(len > rte_pktmbuf_tailroom(m_last)))
> > @@ -1728,7 +1735,7 @@ static inline char *rte_pktmbuf_append(struct rte=
_mbuf
> > *m, uint16_t len)
> >   */
> >  static inline char *rte_pktmbuf_adj(struct rte_mbuf *m, uint16_t len)
> >  {
> > -	__rte_mbuf_sanity_check(m, 1);
> > +	__rte_mbuf_verify(m, 1);
> >=20
> >  	if (unlikely(len > m->data_len))
> >  		return NULL;
> > @@ -1760,7 +1767,7 @@ static inline int rte_pktmbuf_trim(struct rte_mbu=
f *m,
> > uint16_t len)
> >  {
> >  	struct rte_mbuf *m_last;
> >=20
> > -	__rte_mbuf_sanity_check(m, 1);
> > +	__rte_mbuf_verify(m, 1);
> >=20
> >  	m_last =3D rte_pktmbuf_lastseg(m);
> >  	if (unlikely(len > m_last->data_len))
> > @@ -1782,7 +1789,7 @@ static inline int rte_pktmbuf_trim(struct rte_mbu=
f *m,
> > uint16_t len)
> >   */
> >  static inline int rte_pktmbuf_is_contiguous(const struct rte_mbuf *m)
> >  {
> > -	__rte_mbuf_sanity_check(m, 1);
> > +	__rte_mbuf_verify(m, 1);
> >  	return m->nb_segs =3D=3D 1;
> >  }
> >=20
> > diff --git a/lib/mbuf/version.map b/lib/mbuf/version.map
> > index 76f1832924..2950f24caa 100644
> > --- a/lib/mbuf/version.map
> > +++ b/lib/mbuf/version.map
> > @@ -31,6 +31,7 @@ DPDK_25 {
> >  	rte_mbuf_set_platform_mempool_ops;
> >  	rte_mbuf_set_user_mempool_ops;
> >  	rte_mbuf_user_mempool_ops;
> > +	rte_mbuf_verify;
> >  	rte_pktmbuf_clone;
> >  	rte_pktmbuf_copy;
> >  	rte_pktmbuf_dump;
> > --
> > 2.47.2 =20
>=20
> Stephen,
>=20
> I have submitted another patch [1], where __rte_mbuf_raw_sanity_check()'s=
 successor takes one more parameter, so I had to give it a new name __rte_m=
buf_raw_sanity_check_mp() for API compatibility. And then I added:
> +/** For backwards compatibility. */
> +#define __rte_mbuf_raw_sanity_check(m) __rte_mbuf_raw_sanity_check_mp(m,=
 NULL)
>=20
> If you proceed with your patch, __rte_mbuf_raw_sanity_check() will be ren=
amed to __rte_mbuf_raw_verify(), and __rte_mbuf_raw_sanity_check() disappea=
rs.
> Would it make sense to change your patch, so __rte_mbuf_raw_verify() repl=
aces __rte_mbuf_raw_sanity_check_mp() instead of __rte_mbuf_raw_sanity_chec=
k()? If your patch changes the API anyway, adding an extra parameter to the=
 function should be acceptable.
>=20
> [1]: https://patchwork.dpdk.org/project/dpdk/patch/20250722093431.555214-=
1-mb@smartsharesystems.com/

Sure will go back and rebase old patches in a few weeks.
