Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC9FC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:17:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A10454067B;
	Mon, 13 Jul 2026 11:17:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id E675B4028A
 for <dev@dpdk.org>; Mon, 13 Jul 2026 11:17:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783934277; x=1815470277;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vuC7yJ1TaU4Mt/Af8CbOwzB+KH+nkdQ7p2QZieptSqU=;
 b=h2V4YZFt0OtQFVtv7qSjpmvvbGUn9vve3zPUiPlRbXWzIWM4eBIx5VIr
 lQaW5Af+VdmP2GhZDvqAtifxCGvEJQ2bQ57jYw2cJY9f6YKzRar5n05C6
 MDH7w+inzXZlvoaLlVrfLI85pxBWndDWZgdTb9sbpT8DhgXDyTz0kpBzH
 GzU5fu3Gijx3hbep2F/KFKUpAAlyR90GpEAVtWAGZpTIoUO80JZVK8gdl
 MTOeNh+VB6HEOEqVN2zzdRcOnsGevWlSeFg5QCWHieBZH7cODRa+CY4hh
 PL7oHV6xO8ucyQRy55cKnqzJ9zPv7z2TjSgnTi6TE1U8UA76FkDuvvVuv w==;
X-CSE-ConnectionGUID: FJBv4NSNRxKEuy/YVxjObg==
X-CSE-MsgGUID: zx6Rh/GQQi6swFRF/fCEKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94889427"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="94889427"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 02:17:56 -0700
X-CSE-ConnectionGUID: zcCh1TlUQ+qyBH1gR5jzrA==
X-CSE-MsgGUID: OSNZHCtVRJSjt4FeLpcFZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256136151"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa009.jf.intel.com with ESMTP; 13 Jul 2026 02:17:55 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, thomas@monjalon.net,
 stephen@networkplumber.org, marek.kasiewicz@intel.com
Subject: Re: [PATCH v6 0/2] doc: ice: update documentation for rl_burst_size
 devarg
Date: Mon, 13 Jul 2026 05:44:03 -0400
Message-ID: <20260713094403.1721476-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708231926.1550698-2-dawid.wesierski@intel.com>
References: <20260708231926.1550698-2-dawid.wesierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

On Wed, Jul 08, 2026, Bruce Richardson wrote:
> > The paragraph describing the ``rl_burst_size`` devarg was mangled
> > (a mid-sentence line break split "favours throughput" across two
> > lines with no space), 
>
> Are you sure? It looks fine to me in output generated on my machine. Also,
> it's unlikely that changing the source text to add a line break between
> "favours" and "throughput" will cause a line break to be removed in the
> output.

Tbh im not sure. I've dropped the re-wrapping in v6. Your comment makes sense to
me.

> However, the rest of the patch rewrapping the text actually goes against
> DPDK documentation policy. In order to keep doc diffs small, we try to
> always start a sentence on a new line, and to only break lines at
> punctuation marks, or between clauses generally. This saves having massive
> diffs as the source text is re-wrapped following a change at the start of a
> paragraph.
>
> See https://doc.dpdk.org/guides/contributing/documentation.html#line-length-and-wrapping

Fixed in v6. Each sentence now starts on a new line.

> When they are rejected, is an error just logged, or does the driver fail to
> load due to an incorrect value? IF it's just a log message, is it better to
> have the driver do a hard-failure so the user can't miss the issue? That
> would be better than just noting this in the docs.

It is a hard failure. ice_cfg_rl_burst_size() validation failure in 
ice_dev_init() returns -EINVAL, causing the device probe to fail. 
I've updated the documentation text to explicitly state that the 
driver will fail to initialize if an invalid value is provided.

Thanks for the review!

Regards,
Dawid
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

