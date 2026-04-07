Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BACFF5104
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:14:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35F1240265;
	Tue,  7 Apr 2026 17:14:51 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 209714025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:14:50 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2ce22328930so4623608eec.0
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775574889;
 x=1776179689; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=um/e6Oh7kHNRFyBoj4UYgQl/qBzY2WShTo0gtqkF+fY=;
 b=zsoipQ0p4bw/WJFGCt0KmUz/TQdtMS5owFQ06j/4d3E2YVNKXcARsZNixlf31OvYJo
 KuLlI0meP06imbhLdCopzWU/IUl2HAlr9U2AkQfgdytLi7YUCrkIVo4CSJ7sPVUK9rbW
 f6ellkBET80oOJJRBlRcvtHmZzbQxMVAnKXgKoSL/sRJ3gdCoYJxzp/SGUxheuTk5Y7Q
 e5aNmBYIZLuG62KS1XdLOM7GRwKIMnP+1TD9lNVvmvY6joFQxDTIXW9OGJ/aCFkKMfpw
 ylKKAYzFshjeV/cXFOkPq9BRlW8ht3e89LwHkI/m7Fp81bk4aSW5HXAzeXBaq4wHYYeN
 PlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775574889; x=1776179689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=um/e6Oh7kHNRFyBoj4UYgQl/qBzY2WShTo0gtqkF+fY=;
 b=ih4pHbaRbZMGGfIwK8Bd0oY/VZRhTpPV+VaMMLiHM87l4YhjMkxjJ5gbaDFOniuqAJ
 1Nq+jNIH5i63uNX7orFzxCnYsmjEhYoRjKj7Drntnzxi91KZ6l9IJHbViKKs78VFUqg8
 zogDSQMikgDjAcjj/T3buBCi2kLVkEfvwoAE6FeZEvzqhwoWJribl9JmUvrLJ/6aDm0Y
 SDG/RNoc7FztqDiMvAbIF9MezI3oTZXH3PUF3v8+i5Pgl4MvzEUc01kExXBlBmK8Q0P3
 OsmNJDFWOnmy+gH5TsMEZhl/MF14+7yIhxWdgs+3+Or7uzMYNqTagTVY1BtagARt1gzx
 +pHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH8Vdis7njcqwqpAoLzfpdjOXkvsfAR5e33iqNsBVk7Fz+/AqUvzNv0pfB4f1nuOum4pU=@dpdk.org
X-Gm-Message-State: AOJu0YxVoeeJfTmZ7bjH+bZM36j1a4Fnk+m3A/xFsfm7aALWThwg1k20
 xSKDOltnE8oIb/DF8IkKBgvpLRIaFrYXEl89wgKBo6ErmNGGXZcNlNB0eX131A+OSfk=
X-Gm-Gg: AeBDietMCHh7Jna4z247ldUWnc/CREIZZxBiR79D7LSVcOCcKvvmJA3A2MJuN7C4P7g
 gxCjmeiuFA0xBbpM1Sl1Zy/hwzcA1gJqADyOqUydKDO75KTl84fjLUQSD7evuqkxgIru5TxmWMj
 OK19h3Nb+N+POpOZuDa8upJGCIgu1Sk+ddDBu5L6wmrKbRn5+jJdGkDpqp1ye0SenAvXaE3GXv4
 urdy3FCI9sCF5hQdq1f2B2BEwmrT24rjTsOyqxUXIskWwmOmXddf+A1uHxVti3ZGS0ZMe3Mx6e0
 VgH8G2SdU9a05rZZiL8uX1zd/tB2nAYVg68oFSB9wKsYfwNSv6viJ0ETZmiJIb8tgFQuahJha9F
 7wzu98i9AAFMlgCjVKIJghYvKabb5/M8HAu+D9Xw/a4um/l2DX4iUvSqCj7siRNuQ80Tfu0QdpH
 AZ21E0xBMDzpEtFL19RO201meJJKA8ji4xGE4=
X-Received: by 2002:a05:7300:2d24:b0:2be:6f30:f2f9 with SMTP id
 5a478bee46e88-2cbfc16eb7amr10303452eec.26.1775574888849; 
 Tue, 07 Apr 2026 08:14:48 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm15998826eec.29.2026.04.07.08.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:14:48 -0700 (PDT)
Date: Tue, 7 Apr 2026 08:14:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Soumyadeep Hore <soumyadeep.hore@intel.com>,
 <manoj.kumar.subbarao@intel.com>, <aman.deep.singh@intel.com>,
 <dev@dpdk.org>, <rajesh3.kumar@intel.com>
Subject: Re: [PATCH v1] net/idpf: harden PTP frequency adjustment
Message-ID: <20260407081445.39d5cd22@phoenix.local>
In-Reply-To: <abKqLQmzhTE6P6bU@bricha3-mobl1.ger.corp.intel.com>
References: <20260312184344.1475052-1-soumyadeep.hore@intel.com>
 <abKqLQmzhTE6P6bU@bricha3-mobl1.ger.corp.intel.com>
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

On Thu, 12 Mar 2026 11:57:33 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Thu, Mar 12, 2026 at 02:43:44PM -0400, Soumyadeep Hore wrote:
> > Normalize ppm to an unsigned magnitude before using it in the
> > increment value scaling path.
> >=20
> > This avoids negating INT64_MIN and also prevents subtracting 62
> > from the reduced log sum unless the sum is still above the
> > overflow threshold reported by Coverity.
> >=20
> > Coverity issue: 501832
> >=20
> > Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> > ---
> >  drivers/net/intel/idpf/idpf_ethdev.c | 32 +++++++++++++++++-----------
> >  1 file changed, 20 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/i=
dpf/idpf_ethdev.c
> > index 5e57a45775..1c5bd2ee12 100644
> > --- a/drivers/net/intel/idpf/idpf_ethdev.c
> > +++ b/drivers/net/intel/idpf/idpf_ethdev.c
> > @@ -1007,7 +1007,7 @@ idpf_timesync_adjust_freq(struct rte_eth_dev *dev=
, int64_t ppm)
> >  	struct idpf_ptp *ptp =3D adapter->ptp;
> >  	int64_t incval, diff =3D 0;
> >  	bool negative =3D false;
> > -	uint64_t div, rem;
> > +	uint64_t abs_ppm, div, rem;
> >  	uint64_t divisor =3D 1000000ULL << 16;
> >  	int shift;
> >  	int ret;
> > @@ -1016,26 +1016,34 @@ idpf_timesync_adjust_freq(struct rte_eth_dev *d=
ev, int64_t ppm)
> > =20
> >  	if (ppm < 0) {
> >  		negative =3D true;
> > -		ppm =3D -ppm;
> > +		abs_ppm =3D ppm =3D=3D INT64_MIN ? (uint64_t)INT64_MAX + 1 :
> > +			(uint64_t)(-ppm);
> > +	} else {
> > +		abs_ppm =3D (uint64_t)ppm;
> >  	}
> > =20
> >  	/* can incval * ppm overflow ? */
> > -	if (rte_log2_u64(incval) + rte_log2_u64(ppm) > 62) {
> > -		rem =3D ppm % divisor;
> > -		div =3D ppm / divisor;
> > +	if (rte_log2_u64(incval) + rte_log2_u64(abs_ppm) > 62) {
> > +		rem =3D abs_ppm % divisor;
> > +		div =3D abs_ppm / divisor;
> >  		diff =3D div * incval;
> > -		ppm =3D rem;
> > +		abs_ppm =3D rem;
> > +
> > +		if (abs_ppm !=3D 0) {
> > +			uint32_t log_sum;
> > =20
> > -		shift =3D rte_log2_u64(incval) + rte_log2_u64(ppm) - 62;
> > -		if (shift > 0) {
> > -			/* drop precision */
> > -			ppm >>=3D shift;
> > -			divisor >>=3D shift;
> > +			log_sum =3D rte_log2_u64(incval) + rte_log2_u64(abs_ppm);
> > +			if (log_sum > 62) {
> > +				shift =3D log_sum - 62;
> > +				/* drop precision */
> > +				abs_ppm >>=3D shift;
> > +				divisor >>=3D shift;
> > +			}
> >  		}
> >  	}
> > =20
> >  	if (divisor)
> > -		diff =3D diff + incval * ppm / divisor;
> > +		diff =3D diff + incval * abs_ppm / divisor;
> >   =20
>=20
> Asking Claude AI about this code and how to simplify it a bit while also
> avoiding the INT64_MIN issue, it suggests using __int128 type, giving much
> shorter code:
>=20
> 	__int128 diff;
> 	int ret;
>=20
> 	/*
> 	 * ppm is scaled ppm: 1 ppm =3D 2^16 units (matching Linux adjfine).
> 	 * Use __int128 to avoid overflow without complex split/shift logic,
> 	 * and to correctly handle ppm =3D=3D INT64_MIN.
> 	 */
> 	incval =3D ptp->base_incval;
> 	diff =3D ((__int128)incval * ppm) / (1000000LL << 16);
> 	incval +=3D (int64_t)diff;
>=20
> 	ret =3D idpf_ptp_adj_dev_clk_fine(adapter, incval);
> 	if (ret !=3D 0)
> 		PMD_DRV_LOG(ERR, "PTP failed to set incval, err %d", ret);
> 	return ret;
>=20
> Maybe worth considering?
>=20
> /Bruce

Claude AI review of this patch spotted some possible math issues.



Normalize ppm to an unsigned magnitude before using it in the
increment value scaling path.
This avoids negating INT64_MIN and also prevents subtracting 62
from the reduced log sum unless the sum is still above the
overflow threshold reported by Coverity.

The simplification is a nice improvement and the __int128 approach
is correct for realistic hardware values.

One concern:
Warning: drivers/net/intel/idpf/idpf_ethdev.c
The cast (int64_t)diff silently truncates if diff does not fit in
64 bits.  The __int128 multiplication itself never overflows (both
UINT64_MAX =C3=97 INT64_MAX and UINT64_MAX =C3=97 INT64_MIN fit within sign=
ed
__int128), but after dividing by 1000000LL << 16 the quotient can
still exceed INT64_MAX when incval is large and ppm is extreme.
For realistic PTP hardware (base_incval around 2^32) this is fine,
but the API accepts the full int64_t range without documented bounds.
Adding an explicit clamp or assertion before the cast would preserve
the defensive character of the code being replaced:
