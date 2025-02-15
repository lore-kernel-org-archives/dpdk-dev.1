Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8B4C021A0
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 15:25:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C22B4400D7;
	Sat, 15 Feb 2025 16:25:32 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0A6BC40041
 for <dev@dpdk.org>; Sat, 15 Feb 2025 16:25:32 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D1BED2077A;
 Sat, 15 Feb 2025 16:25:31 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v6 02/11] eal: add new secure free function
Date: Sat, 15 Feb 2025 16:25:29 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FA3F@smartserver.smartshare.dk>
In-Reply-To: <20250213221819.1856769-3-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v6 02/11] eal: add new secure free function
Thread-Index: Adt+ZT57632VVikbTh+IBeS8/hh/AABWFpyg
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250213221819.1856769-1-stephen@networkplumber.org>
 <20250213221819.1856769-3-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Tyler Retzlaff" <roretzla@linux.microsoft.com>
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

> +
> +/**

Missing:
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *

> + * Frees the memory space pointed to by the provided pointer
> + * and guarantees it will be zero'd before reuse. Since this
> + * function is slower than simple rte_free() it should only
> + * be used for security keys and other sensitive data.
> + *
> + * This pointer must have been returned by a previous call to
> + * rte_malloc(), rte_zmalloc(), rte_calloc() or rte_realloc(). The
> behaviour of
> + * rte_free() is undefined if the pointer does not match this
> requirement.
> + *
> + * If the pointer is NULL, the function does nothing.
> + *
> + * @param ptr
> + *   The pointer to memory to be freed.
> + */
> +__rte_experimental
> +void
> +rte_free_sensitive(void *ptr);
> +

With the warning added to the description,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

