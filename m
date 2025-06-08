Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D734C5AD49
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 22:34:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D3A44026B;
	Mon,  9 Jun 2025 00:34:47 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 4FADC4025F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 00:34:44 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7cadc92771dso350062785a.1
 for <dev@dpdk.org>; Sun, 08 Jun 2025 15:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749422083;
 x=1750026883; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3/d/C+qymLdPNMWglpX9IefsBj7sj4cbKqXmR/RiVA=;
 b=2vbB5L3ITIk0fy8bQgXb+sqYhhtkhxMkVoQT52YSBVoBBf0KEeryT1DdWfkC/r/2tz
 GsxMOdCY8koi/qqY9wNCjDTquE+Xk+fkza9YrrIP2TP5nyxw/JS2vFQP3eYViUvx0CRX
 0e49WodIxJrqHVhDc2ihsCbTGGRkc9ELEVE4VJTLIaroydMQpMPU8cOAihUX8YdoIZpi
 Jn5L2rzBSBdSCNnPbmY17n8KFlEyVD/k9OQw1Osvc1J/Tx/oqQ9fNP8iCjomOiD+tzrk
 rTET4iSDGRr/fSNphxbGKmFdohRP6ILTxB84pjy7Clb4y8I62cXWHBBqOJa+fBx8OGCx
 BGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749422083; x=1750026883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3/d/C+qymLdPNMWglpX9IefsBj7sj4cbKqXmR/RiVA=;
 b=suYHMb+U6O+Ex+7Oxjoy66kJ+3JX86IuZeURftDO/n/O8+XWilYzrm/+bRvBJDUUZU
 qXDDuN8lMagPjNET37nEy38UcVTmHP/dMli7rLi0xcTIj7WImcku7fsFrziA/m6uznYA
 AZBaTdW8q7hG1roB7zscBZ1Nh//XOqfet3NHqoRkWkMBDQJR56+8GSQYrAIPhOIwVbJC
 PTP+sF8wv6OEk4socem0Z5c+eqRqOXdr5fqnkxwi4a7BavnJR/FOzQrukuJjo6H6vyqT
 9b6+cWft7LO2IastiknfqDuea6ggM6pbA5SYDPbxdVX7g2rjizM3PHj/osqmbXFo+Lqo
 VTMQ==
X-Gm-Message-State: AOJu0Yy1ne32b6ZqNl2maM9UEq8s4yXmEVonQvdZ9oGcakQF/+IAu8Dj
 ZvJDhN2Ss4xWxHPPWhePaqxmlP3x1FH6LrpCTQdYgNYSwWiwhFuao3e5npi+6lo2Jt0=
X-Gm-Gg: ASbGncvua9hRXCJ6bMK7ICRH8Fje4cDZhTPL2/+M7XECHLFRvU2mUsFDL6qb19WekQ2
 vXWa3HIU8OzzeR9DiRI6SlOX1Tn2O/hw//1/Hl+VJ3ljP4pjxOo8nN9PTgmIOdQ9C22y98jPmdH
 9eqcwjNg3B5eWqVME3TT4axVX390bwqNy8SwltTc0QQyPsfgEu2oLZGTKFstC8XzNxuu06kozc9
 sH4UQLwK7SGpUBmTeBrhhKw9SNql0EjLRCCTEyjscAitbIGIedY//NTIieUTVNkOyjvvbR0/DxG
 oQ61DefNVwf1zW8dTA6wb1iRBu8iY2EeoLQ+3kAHvMSIVMBK/oDO3WR0yPeKXUEYeo26Sf6mh5e
 2GL9k4phIIOjLiSl4FA7qKIgMoiok
X-Google-Smtp-Source: AGHT+IEKesrcq2S9Tsx27hzWSCgb6VxkKq509/k5EhDPsv7OVwiavRheUXmPRbVQiY1xfSO6B2iQcQ==
X-Received: by 2002:a05:620a:29d5:b0:7d2:1953:a410 with SMTP id
 af79cd13be357-7d22988e774mr1402374185a.17.1749422083455; 
 Sun, 08 Jun 2025 15:34:43 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d25a61a889sm464270885a.83.2025.06.08.15.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 15:34:43 -0700 (PDT)
Date: Sun, 8 Jun 2025 15:34:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Message-ID: <20250608153439.322f6c88@hermes.local>
In-Reply-To: <20250606215208.389096-1-schneide@qti.qualcomm.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250606215208.389096-1-schneide@qti.qualcomm.com>
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

On Fri,  6 Jun 2025 15:52:08 -0600
Schneide <schneide@qti.qualcomm.com> wrote:

> From: Dylan Schneider <schneide@qti.qualcomm.com>
>=20
> Allow the user to specify protocol link type when creating pcapng files.
> This change is needed to specify the protocol type in the pcapng file,
> DLT_EN10MB specifies ethernet packets only. This will allow dissectors
> for other protocols to be used on files generated by pcapng.
>=20
> Includes a breaking change to rte_pcapng_add_interface to add link_type
> parameter. Existing calls to the function have been updated to pass
> DLT_EN10MB for the link type argument.
>=20
> Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
> Cc: stephen@networkplumber.org
> ---
>  .mailmap                               |  1 +
>  app/dumpcap/main.c                     |  4 ++--
>  app/test/test_pcapng.c                 |  8 ++++----
>  doc/guides/rel_notes/release_25_07.rst |  5 ++++-
>  lib/graph/graph_pcap.c                 |  4 +++-
>  lib/pcapng/meson.build                 |  2 ++
>  lib/pcapng/rte_pcapng.c                | 21 +++++++++++++++------
>  lib/pcapng/rte_pcapng.h                |  4 +++-
>  8 files changed, 34 insertions(+), 15 deletions(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index 91e08f4a1f..a585124832 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -390,6 +390,7 @@ Dukai Yuan <dukaix.yuan@intel.com>
>  Dumitru Ceara <dceara@redhat.com> <dumitru.ceara@gmail.com>
>  Duncan Bellamy <dunk@denkimushi.com>
>  Dustin Lundquist <dustin@null-ptr.net>
> +Dylan Schneider <schneide@qti.qualcomm.com>
>  Dzmitry Sautsa <dzmitryx.sautsa@intel.com>
>  Ed Czeck <ed.czeck@atomicrules.com>
>  Eduard Serra <eserra@vmware.com>
> diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
> index 3d3c0dbc66..e0e2b26269 100644
> --- a/app/dumpcap/main.c
> +++ b/app/dumpcap/main.c
> @@ -800,8 +800,8 @@ static dumpcap_out_t create_output(void)
>  		free(os);
> =20
>  		TAILQ_FOREACH(intf, &interfaces, next) {
> -			if (rte_pcapng_add_interface(ret.pcapng, intf->port, intf->ifname,
> -						     intf->ifdescr, intf->opts.filter) < 0)
> +			if (rte_pcapng_add_interface(ret.pcapng, intf->port, DLT_EN10MB,
> +				intf->ifname, intf->ifdescr, intf->opts.filter) < 0)
>  				rte_exit(EXIT_FAILURE, "rte_pcapng_add_interface %u failed\n",
>  					intf->port);
>  		}
> diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
> index 8f2cff36c3..bcf99724fa 100644
> --- a/app/test/test_pcapng.c
> +++ b/app/test/test_pcapng.c
> @@ -345,7 +345,7 @@ test_add_interface(void)
>  	}
> =20
>  	/* Add interface to the file */
> -	ret =3D rte_pcapng_add_interface(pcapng, port_id,
> +	ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
>  				       NULL, NULL, NULL);
>  	if (ret < 0) {
>  		fprintf(stderr, "can not add port %u\n", port_id);
> @@ -353,7 +353,7 @@ test_add_interface(void)
>  	}
> =20
>  	/* Add interface with ifname and ifdescr */
> -	ret =3D rte_pcapng_add_interface(pcapng, port_id,
> +	ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
>  				       "myeth", "Some long description", NULL);
>  	if (ret < 0) {
>  		fprintf(stderr, "can not add port %u with ifname\n", port_id);
> @@ -361,7 +361,7 @@ test_add_interface(void)
>  	}
> =20
>  	/* Add interface with filter */
> -	ret =3D rte_pcapng_add_interface(pcapng, port_id,
> +	ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
>  				       NULL, NULL, "tcp port 8080");
>  	if (ret < 0) {
>  		fprintf(stderr, "can not add port %u with filter\n", port_id);
> @@ -406,7 +406,7 @@ test_write_packets(void)
>  	}
> =20
>  	/* Add interface to the file */
> -	ret =3D rte_pcapng_add_interface(pcapng, port_id,
> +	ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
>  				       NULL, NULL, NULL);
>  	if (ret < 0) {
>  		fprintf(stderr, "can not add port %u\n", port_id);
> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_note=
s/release_25_07.rst
> index 6b070801de..2396c7b014 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -108,7 +108,10 @@ API Changes
>     This section is a comment. Do not overwrite or remove it.
>     Also, make sure to start the actual text at the margin.
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> -
> +* pcapng: Changed the API for adding interfaces to include a link type a=
rgument.
> +  The link type was previously hardcoded to the ethernet link type in th=
e API.
> +  This argument is added to ``rte_pcapng_add_interface``.
> +  These functions are versioned to retain binary compatibility until the=
 next LTS release.
> =20
>  ABI Changes
>  -----------
> diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c
> index 89525f1220..13d86b7a18 100644
> --- a/lib/graph/graph_pcap.c
> +++ b/lib/graph/graph_pcap.c
> @@ -11,6 +11,8 @@
>  #include <rte_mbuf.h>
>  #include <rte_pcapng.h>
> =20
> +#include <pcap/pcap.h>
> +
>  #include "rte_graph_worker.h"
> =20
>  #include "graph_pcap_private.h"
> @@ -117,7 +119,7 @@ graph_pcap_file_open(const char *filename)
> =20
>  	/* Add the configured interfaces as possible capture ports */
>  	RTE_ETH_FOREACH_DEV(portid) {
> -		ret =3D rte_pcapng_add_interface(pcapng_fd, portid,
> +		ret =3D rte_pcapng_add_interface(pcapng_fd, portid, DLT_EN10MB,
>  					       NULL, NULL, NULL);
>  		if (ret < 0) {
>  			graph_err("Graph rte_pcapng_add_interface port %u failed: %d",
> diff --git a/lib/pcapng/meson.build b/lib/pcapng/meson.build
> index 4549925d41..3aa7ba5155 100644
> --- a/lib/pcapng/meson.build
> +++ b/lib/pcapng/meson.build
> @@ -5,3 +5,5 @@ sources =3D files('rte_pcapng.c')
>  headers =3D files('rte_pcapng.h')
> =20
>  deps +=3D ['ethdev']
> +
> +use_function_versioning =3D true
> diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
> index cacbefdc50..f18af25983 100644
> --- a/lib/pcapng/rte_pcapng.c
> +++ b/lib/pcapng/rte_pcapng.c
> @@ -200,11 +200,10 @@ pcapng_section_block(rte_pcapng_t *self,
>  }
> =20
>  /* Write an interface block for a DPDK port */
> -RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)
> -int
> -rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
> -			 const char *ifname, const char *ifdescr,
> -			 const char *filter)
> +RTE_DEFAULT_SYMBOL(26, int, rte_pcapng_add_interface,
> +			(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
> +			const char *ifname, const char *ifdescr,
> +			const char *filter))
>  {
>  	struct pcapng_interface_block *hdr;
>  	struct rte_eth_dev_info dev_info;
> @@ -274,7 +273,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t=
 port,
>  	hdr =3D (struct pcapng_interface_block *)buf;
>  	*hdr =3D (struct pcapng_interface_block) {
>  		.block_type =3D PCAPNG_INTERFACE_BLOCK,
> -		.link_type =3D 1,		/* DLT_EN10MB - Ethernet */
> +		.link_type =3D link_type,
>  		.block_length =3D len,
>  	};
> =20
> @@ -319,6 +318,16 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_=
t port,
>  	return write(self->outfd, buf, len);
>  }
> =20
> +RTE_VERSION_SYMBOL(25, int, rte_pcapng_add_interface,
> +				  (rte_pcapng_t *self, uint16_t port,
> +				   const char *ifname, const char *ifdescr,
> +				   const char *filter))
> +{
> +	/* Call the new version with a default link_type (Ethernet) */
> +	return rte_pcapng_add_interface(self, port, DLT_EN10MB,
> +									ifname, ifdescr, filter);
> +}
> +
>  /*
>   * Write an Interface statistics block at the end of capture.
>   */
> diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
> index 48f2b57564..9880d415c4 100644
> --- a/lib/pcapng/rte_pcapng.h
> +++ b/lib/pcapng/rte_pcapng.h
> @@ -71,6 +71,8 @@ rte_pcapng_close(rte_pcapng_t *self);
>   *  The handle to the packet capture file
>   * @param port
>   *  The Ethernet port to report stats on.
> + * @param link_type
> + *=C2=A0=C2=A0 The link type (e.g., DLT_EN10MB).
>   * @param ifname (optional)
>   *  Interface name to record in the file.
>   *  If not specified, name will be constructed from port
> @@ -84,7 +86,7 @@ rte_pcapng_close(rte_pcapng_t *self);
>   * must be added.
>   */
>  int
> -rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
> +rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t lin=
k_type,
>  			 const char *ifname, const char *ifdescr,
>  			 const char *filter);
> =20

Build is failing, DLT_EN10MB is not available in all configs.
