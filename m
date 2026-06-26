Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB0CCD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 09:55:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96E2040265;
	Fri, 26 Jun 2026 11:55:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 1EBDF4025F
 for <dev@dpdk.org>; Fri, 26 Jun 2026 11:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782467735; x=1814003735;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I2h41GZdv9pm/ucTUvaTc/5mC8AdvFniDq4EL28XeP8=;
 b=PH1R1cFkvaNn2EDFD5a6Z9niEXxqEL4Kjg4/5fZ0cjFBa1qv6lU+t+Sn
 ewUzZESkOitIVr/txPXN9RVxhLm7TUllMfl/7Q42sBFE4RKWln/TRuA2k
 5evbFVL74DBjE55z7ZYiJ+L8EwABH4/A7A31Tslgs+s1CEjG5mp65Y7Dh
 YcI7bs5lk+kYdTE7J/2IHeTHOurmTBcJGAywqwBWXAdGZHpUEus+W4wpr
 qHM2ArwQtTqq9udzw+0L5qZSYC4mzMYCyMCNT8QxEzHDFfGzkfKMPMwTC
 CLeJ65MqDjg+6Dq3AYgSNp8YM60U3t3Hu05h+QQyaTP2F79uCHTJcn/De w==;
X-CSE-ConnectionGUID: 2gtfrDwqSWGZACR6C/a9RA==
X-CSE-MsgGUID: PvOELytlQ2eJhGyX75w3XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="100809347"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="100809347"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 02:55:33 -0700
X-CSE-ConnectionGUID: e4wU+To+RnO9jM8u5L1cLg==
X-CSE-MsgGUID: 330/XRe7QWu5PctQzmep3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="254901343"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa003.jf.intel.com with ESMTP; 26 Jun 2026 02:55:31 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: dawid.wesierski@intel.com, marek.kasiewicz@intel.com, thomas@monjalon.net,
 stephen@networkplumber.org, mb@smartsharesystems.com
Subject: Re: [v5] pcapng: add user-supplied timestamp support
Date: Fri, 26 Jun 2026 06:22:04 -0400
Message-ID: <20260626102213.776257-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624215858.710217-1-dawid.wesierski@intel.com>
References: <20260624215858.710217-1-dawid.wesierski@intel.com>
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

Thanks again for the review,

For v6 I have added the input validation we ccheck if the timestamp
PCAPNG_TSC_FLAG is not set on caller-provided input.

Regarding API versioning my concern is around source-level compatibility.
Any application that calls rte_pcapng_copy() would need to be updated to
pass the additional timestamp argument right?

Is breaking source-level compatibility for existing callers of
rte_pcapng_copy() acceptable here?
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

