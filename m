Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236A8C3ABCB
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 14:26:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4D96402CA;
	Mon, 12 May 2025 16:26:47 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 5C2EF402C9
 for <dev@dpdk.org>; Mon, 12 May 2025 16:26:46 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4Zx23n3lZsz4PWJ;
 Mon, 12 May 2025 14:26:45 +0000 (UTC)
 (envelope-from jfree@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4Zx23n2sjNz45N3;
 Mon, 12 May 2025 14:26:45 +0000 (UTC)
 (envelope-from jfree@freebsd.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1747060005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+PeTrbRHJJqYRV2P74n6rhk+BCJRBODw+O7MqwLzR70=;
 b=gbX2OW0NhtpzQOAyUiM39R7R2LioWgLpDQWyuJhN7MkUO9786H1exZRAbPpsc+YU4D9Jk7
 TqK3SPKF7Kvoc8GHfCCAWRRuOC9pFEjf5b2+CZ/dQ+O4jFYF7wwnxeGPoIy8cxINzUFh3J
 2I52jjK0+3wWmPSjVqX+5/BPbiUQ1kc3zUel3uv8SGBMTzqKpmnAaN0Ztq9SEgXw7HDyLZ
 GzLktq2inu6BfD818qzTMBlaoUlbSfaw/w3grGcQaxJ9kZH091IuBsDdUXHP5G0X3y73wW
 iG4j9lJoJzt5/Br75chozZa8bho7nMyWnAagqCWKNYfaVbw16D7xDKrdfkta1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1747060005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+PeTrbRHJJqYRV2P74n6rhk+BCJRBODw+O7MqwLzR70=;
 b=DK30Edkn+rsID1L/l0ICR8t9z/9FPde8ifQmHZ973zkFVY5JTn7+80/APJbtoFSnao0K3G
 Y8qhjm02RxVpsWo4/IJZUhnLqyfqs4nqLPV64Hbedl5N2nOCjAr0OWTVha7URbij7Kp/F2
 2FHTh0vzN9eeTwHcEWE3WGhczKyKNAZFbXBlxJyGjnZdXf68cUGB2hjc2VaCb64/kCMZAA
 TVII67neUHuWMliWJNjWcNbGNE85ovW7ZTPP8+TFnej8tK+uB1827cRVGkJwrUZDzeXNx3
 a8+Gf/t4yFYkeSWR5PUYLQMI9rHDxJLrUHOrBT/uEcUfkw0tpFp3DIu39P6zVw==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1747060005; a=rsa-sha256; cv=none;
 b=G7283DWe1m4fsBqrLbTZD0esS91dbrI8rF305dMSOZsZKJlJj9Lrfqln1F3mxC3+XHYcaW
 EadVX03GSddJ4LK4N/tX7T6MZOTYx3KvqR5i3Z5DV928ZcFehFo6UxQFEkx7OfVnRR+2PH
 nwkrQnvuFrrOlO3u00r+JnW9QdomcPkE6li8feRa2uCi/nM0i2DPWOvM6IYHjPsfBbez1R
 NTTRXuj6ojsU9eWJtfbfijsSikrgmyfYL4HMqQoxnLE/yTg1sTszGyszlZgeYpcirpEd5B
 1PCT71Z11dcZavW9ZJj2rN0FHxnUZOAYa8i2hTCzoqKS0Uu69G3H8lFz4QzRcg==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from localhost (67-4-147-206.mpls.qwest.net [67.4.147.206])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4Zx23m6wvwzmnt;
 Mon, 12 May 2025 14:26:44 +0000 (UTC)
 (envelope-from jfree@freebsd.org)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 May 2025 09:26:44 -0500
Message-Id: <D9U9327H5W8O.EKJ2V2MNZM97@freebsd.org>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "Jake Freeland"
 <jfree@FreeBSD.org>, "Chenbo Xia" <chenbox@nvidia.com>, "Nipun Gupta"
 <nipun.gupta@amd.com>, "Tyler Retzlaff" <roretzla@linux.microsoft.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH 1/4] bus/pci: Use force-noreplace flag when mapping PCI
 resources
From: "Jake Freeland" <jfree@freebsd.org>
X-Mailer: aerc 0.18.2
References: <20250506174046.1136711-1-jfree@FreeBSD.org>
 <20250506174046.1136711-2-jfree@FreeBSD.org>
 <53d50d81-75ae-4d23-89b2-bfd6e5733550@intel.com>
In-Reply-To: <53d50d81-75ae-4d23-89b2-bfd6e5733550@intel.com>
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

On Thu May 8, 2025 at 6:32 AM CDT, Anatoly Burakov wrote:
> On 5/6/2025 7:40 PM, Jake Freeland wrote:
> > When mapping PCI resources in secondary processes, use the
> > RTE_MAP_FORCE_ADDRESS_NOREPLACE flag to indicate that the
> > mapping must be made at the provided address.
> >=20
> > Without this flag, the kernel might return a different address for
> > the mapping, even if the requested region was available.
> >=20
> > Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> > ---
> >   drivers/bus/pci/pci_common_uio.c | 4 +++-
> >   lib/eal/common/eal_private.h     | 7 ++++++-
> >   lib/eal/include/rte_eal_paging.h | 7 ++++++-
> >   lib/eal/unix/eal_unix_memory.c   | 8 +++++++-
> >   4 files changed, 22 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/bus/pci/pci_common_uio.c b/drivers/bus/pci/pci_com=
mon_uio.c
> > index 30503bd23a..71974e9f56 100644
> > --- a/drivers/bus/pci/pci_common_uio.c
> > +++ b/drivers/bus/pci/pci_common_uio.c
> > @@ -10,6 +10,7 @@
> >   #include <sys/mman.h>
> >  =20
> >   #include <rte_eal.h>
> > +#include <rte_eal_paging.h>
> >   #include <rte_pci.h>
> >   #include <rte_bus_pci.h>
> >   #include <rte_tailq.h>
> > @@ -58,7 +59,8 @@ pci_uio_map_secondary(struct rte_pci_device *dev)
> >  =20
> >   			void *mapaddr =3D pci_map_resource(uio_res->maps[i].addr,
> >   					fd, (off_t)uio_res->maps[i].offset,
> > -					(size_t)uio_res->maps[i].size, 0);
> > +					(size_t)uio_res->maps[i].size,
> > +					RTE_MAP_FORCE_ADDRESS_NOREPLACE);
> >  =20
> >   			/* fd is not needed in secondary process, close it */
> >   			close(fd);
> > diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.=
h
> > index 04ba8ddb86..aaeb140eaf 100644
> > --- a/lib/eal/common/eal_private.h
> > +++ b/lib/eal/common/eal_private.h
> > @@ -211,7 +211,12 @@ enum eal_mem_reserve_flags {
> >   	 * @see RTE_MAP_FORCE_ADDRESS for description of possible consequenc=
es
> >   	 *      (although implementations are not required to use it).
> >   	 */
> > -	EAL_RESERVE_FORCE_ADDRESS =3D 1 << 1
> > +	EAL_RESERVE_FORCE_ADDRESS =3D 1 << 1,
> > +	/**
> > +	 * Force reserving memory at the requested address, but fail if a
> > +	 * preexisting mapping collides with the request.
> > +	 */
> > +	EAL_RESERVE_FORCE_ADDRESS_NOREPLACE =3D 1 << 2,
> >   };
> >  =20
> >   /**
> > diff --git a/lib/eal/include/rte_eal_paging.h b/lib/eal/include/rte_eal=
_paging.h
> > index c60317d0f5..7b1983b615 100644
> > --- a/lib/eal/include/rte_eal_paging.h
> > +++ b/lib/eal/include/rte_eal_paging.h
> > @@ -34,7 +34,12 @@ enum rte_map_flags {
> >   	 * may remove all other mappings in the requested region. However,
> >   	 * it is not required to do so, thus mapping with this flag may fail=
.
> >   	 */
> > -	RTE_MAP_FORCE_ADDRESS =3D 1 << 3
> > +	RTE_MAP_FORCE_ADDRESS =3D 1 << 3,
> > +	/**
> > +	 * Force mapping to the requested address, but fail if a preexisting
> > +	 * mapping collides with the request.
> > +	 */
> > +	RTE_MAP_FORCE_ADDRESS_NOREPLACE =3D 1 << 4,
> >   };
> >  =20
> >   /**
> > diff --git a/lib/eal/unix/eal_unix_memory.c b/lib/eal/unix/eal_unix_mem=
ory.c
> > index c540f1e838..61e914b8db 100644
> > --- a/lib/eal/unix/eal_unix_memory.c
> > +++ b/lib/eal/unix/eal_unix_memory.c
> > @@ -17,11 +17,13 @@
> >   #ifdef RTE_EXEC_ENV_LINUX
> >   #define EAL_DONTDUMP MADV_DONTDUMP
> >   #define EAL_DODUMP   MADV_DODUMP
> > +#define EAL_FIXED_NOREPLACE MAP_FIXED_NOREPLACE
>
> Is this available in all supported Linux kernel versions?

Support for the MAP_FIXED_NOREPLACE flag was adding in Linux 4.17.

It looks like we're still supporting DPDK 22.11 until Dec 2025. When
22.11 was released, the most recent LTS kernel version was 5.15.

Additionally, the man page specifies:

"older kernels which  do not recognize the MAP_FIXED_NOREPLACE flag will
typically (upon detecting a collision with a preexisting mapping) fall
back to a =E2=80=9Cnon-MAP_FIXED=E2=80=9D type of behavior"

Thanks,
Jake Freeland
