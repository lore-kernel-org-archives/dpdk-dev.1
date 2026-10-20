Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F24606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f4UOR7J4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A26FF4066C;
	Tue, 20 Oct 2026 17:21:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id CA02E40A81
 for <dev@dpdk.org>; Tue, 20 Oct 2026 17:21:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792509707; x=1824045707;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G/5rSN3Z/DorPhnKhrY0EizTvaeWiFvL8kzso8Pncrc=;
 b=f4UOR7J4BoHat4qtEq5fEhUijV8Tld/0kFUnyThshQES2Xs2hES4HZiP
 QJMVWNXuAzojw8qmneC04YF/35alZTM2k+KCEv4Ji+8xZcXfT1gd+pViV
 RXqpiisw94078KCP2AlO3tXWeMS3BYq10yQgHHRz9/7kd4N994IhzsuDB
 ye99kHR31RH7BYk315U/K3bwn+oX/WYg3PuO28u+BALrZ5Bs8jDghigXN
 QxDfv4zN2rvIzluUTGkSXeQgSP7anw0vyfv7oIdupkGfNTOry0Ctba6co
 w5l568V3nlM+YT7B/M2FQfSJ/TVlcP4phkkSsJeCwj2E+X07JUPg/UL8r Q==;
X-CSE-ConnectionGUID: hVuQcl02TuilpRemddVlKw==
X-CSE-MsgGUID: Cg9oIfxnQYOxN04biHbWkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1226893"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1226893"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 08:21:46 -0700
X-CSE-ConnectionGUID: Nt6LVZSGQjum2XKNJI4gUw==
X-CSE-MsgGUID: uDHfNuMBQY6hlD6GNPlztA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3241062"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by orviesa010.jf.intel.com with ESMTP; 20 Oct 2026 08:21:45 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, thomas@monjalon.net, reshma.pattan@intel.com,
 mb@smartsharesystems.com, marek.kasiewicz@intel.com
Subject: Re: [PATCH v7] pcapng: add user-supplied timestamp support
Date: Tue, 20 Oct 2026 15:22:34 +0000
Message-ID: <20261020152234.2599119-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014103858.5a454dac@phoenix.local>
References: <20261014172102.1090177-1-dawid.wesierski@intel.com>
 <20261014103858.5a454dac@phoenix.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 14 Oct 2026 10:38:58 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:
> On Wed, 14 Oct 2026 17:21:01 +0000
> Dawid Wesierski <dawid.wesierski@intel.com> wrote:
>
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pcapng_tsc_to_ns, 26.11)
> > +uint64_t
> > +rte_pcapng_tsc_to_ns(const rte_pcapng_t *self, uint64_t tsc)
> > +{
> > +	return pcapng_timestamp(self, tsc);
> > +}
> > +
>
> Since the tsc_to_ns is independent of the pcapng handle, I had some
> patches in other work which made it not require pcapng_open and/or move
> it to EAL. What do you think?

Agreed. The conversion uses only the TSC and wall clock reference that
rte_pcapng_fdopen() takes. Nothing else in the handle is necessary.
A helper in EAL is better: other code can use it too, for example
rpcapd, to stamp a packet with its capture time and not with the
time of the burst.

Our application does not need rte_pcapng_tsc_to_ns(). It gives the
PTP time of the NIC to rte_pcapng_copy(). Thus I will send v8 without
rte_pcapng_tsc_to_ns(), and the patch then does only the API change
of rte_pcapng_copy(). Your helper can come in its own series, with
its users.

One point for your helper, and for any code that reads back the block
from rte_pcapng_copy() before rte_pcapng_write_packets(): with this
patch, the timestamp field holds the TSC with bit 63 set, or the
caller time in nanoseconds with bit 63 clear.

A question on the schedule. 26.11-rc1 is out, and this patch changes
the API of rte_pcapng_copy(). v6 has the state Accepted in patchwork
since June, but it is not in main. Can v8 go into 26.11? If it must
wait for the next ABI version, please tell me. We will then keep it in
our DPDK patch set until that release.

v8 is tested with pcapng_autotest (also with ASan) on 26.11-rc1, and
with dpdk-dumpcap on testpmd for the TSC path.

Thanks,
Dawid
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

