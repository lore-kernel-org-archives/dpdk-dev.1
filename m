Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27795C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 16:21:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5377C40263;
	Tue, 11 Mar 2025 17:21:17 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E91784014F
 for <dev@dpdk.org>; Tue, 11 Mar 2025 17:21:15 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AEA4321371;
 Tue, 11 Mar 2025 17:21:15 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 1/3] eal: add function rte_size_to_str
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 11 Mar 2025 17:21:14 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FAED@smartserver.smartshare.dk>
In-Reply-To: <1741707195-26880-1-git-send-email-andremue@linux.microsoft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 1/3] eal: add function rte_size_to_str
Thread-Index: AduSmvTfQOc1XlYZQ9OvN992+vkKzgABTQvg
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <1741707195-26880-1-git-send-email-andremue@linux.microsoft.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Andre Muezerie" <andremue@linux.microsoft.com>
Cc: <bruce.richardson@intel.com>, <dev@dpdk.org>, <sameh.gobriel@intel.com>,
 <vladimir.medvedkin@intel.com>, <yipeng1.wang@intel.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
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

> +	return snprintf(buf, buf_size, "%.*f%c%s", precision,
> +			(double)count / powi, *prefix, use_iec ? "i" : "");

I prefer a space between the number and the postfix (if a postfix is =
present), e.g. "1.23 M", so when followed by the unit, it becomes "1.23 =
Mbit/s" rather than "1.23M bit/s".

> +/**
> + * Converts the uint64_t value provided to a human-readable string.
> + * It null-terminates the string, truncating the data if needed.

Please add some examples showing the output formatting.
E.g.: "123 M", "12.3 M",
"12 M", " 12 M" or "12.0 M",
"1.00  ", "  1.00", or "     1", or something else?

> + *
> + * @param buf
> + *     Buffer to write the string to.
> + * @param buf_size
> + *     Size of the buffer.
> + * @param count
> + *     Number to convert.
> + * @param use_iec
> + *     If true, use IEC units (1024-based), otherwise use SI units
> (1000-based).
> + * @return
> + *     Number of characters written (not including the null-
> terminator),
> + *     or that would have been required when the buffer is too small.
> + */
> +int
> +rte_size_to_str(char *buf, int buf_size,
> +		uint64_t count, bool use_iec);
> +
