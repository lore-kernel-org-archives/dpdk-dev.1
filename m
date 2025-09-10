Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE87CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 13:00:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED72A40653;
	Wed, 10 Sep 2025 15:00:45 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 92A0A40270;
 Wed, 10 Sep 2025 15:00:43 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id B78AF1D00255;
 Wed, 10 Sep 2025 09:00:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 10 Sep 2025 09:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1757509242;
 x=1757595642; bh=w/S3Qb5aKwoGKj51XwEM5gmSOz0eRf6V4x468Vb6MAc=; b=
 ZFAH7FK6L2dUFfkBqC5hjiol3oJBPcliYj89spupvyTNEVIYaCjJuArwRGH7XSjd
 +O1vkCOvPQ3JZn3i5ToE4m0FMf9Xg4LLlSIvUbF0XvezHaoGAaNRBRQ8q7eHl94Q
 2oyod9VtG7VR8I/HyOsX13Xo/mkqDFvXCT/k0Q6ysIxxfbyZfGmucWSHQ+IELWoJ
 w8EJDBDWdEJauemwBdXYX0pxS1hAkN2ODBRUVIVcUKlIZAbfsJOFEZXNE8oXoeWe
 jImAcz6gXXlcod+zU0MZ1hrgClYKyDLxshkA5/tawX3uPUQWB+Vj+MPPa3WdIu0J
 FStJfid/m6oFnuPlryD2pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757509242; x=
 1757595642; bh=w/S3Qb5aKwoGKj51XwEM5gmSOz0eRf6V4x468Vb6MAc=; b=h
 W0zPUXGru+WJe+ZChJme8AKZdLwCQEg6K1kVTcJYJSjGp3obfGDTKYYSh2yMPIkf
 hk6f5SOxn28GeOG+YM8J23i3xkhDeYNWOvtcDixAHb9COg2DJpxqwjfCP7hN4hph
 oKBcePTIMy1pCJ99cYjqnLVhC+aEY7oFslCAnT9t9bnNGWA3r5IunI0VoBpFQbyJ
 ZYeLE4WRPhCmDd4KdbTgOrCQA5B4M1tWAg8C0wN1sInTrKcjz40WSLPI82FfWpDi
 g+oYN72d+Pby7Kd59mA2y5MKJayNxfmIeYWpm/h5vJCgcaum8YAvvOLKVHuileg7
 lqbpZyJnB7CvQZRVGj0ew==
X-ME-Sender: <xms:enbBaKS6quWJkaa-LTLMwASbHoCxe_mdh6OOJ4sQdVUjj9doxv-a9A>
 <xme:enbBaNsXysrltIPJvPcO3jYYiEpnZKMd3F4-KG7Cc_nJ-ugmJjFyGeQDf4ET-ZhtI
 HVXazw-J5TulEaydw>
X-ME-Received: <xmr:enbBaKIr0MjzX4LJm-p0Qp5a8SHLP221Riu7v-GgYVlerxNcSwU87RUECAQ5Q3_DLSrbw3acH8QGWU6VS_RDMeoQpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeefhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgt
 hhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehhvghmrghnthdrrghgrh
 grfigrlhesnhigphdrtghomhdprhgtphhtthhopehnihgtohhlrghsrdgthhgruhhtrhhu
 sehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgtohhquhgvlhhinhesrh
 gvughhrghtrdgtohhm
X-ME-Proxy: <xmx:enbBaKl68YXceFXMU8zo492K-LaQnHuDXw8hL1IBWnPITZiA1DkdQw>
 <xmx:enbBaLJ_voGZLzh8j2qfsgj_qdSdk_LVkRfaNsfkyPOLRQRG7YwDNw>
 <xmx:enbBaP4ZZN-NTB6jKPw2iIswdvel9pJFYZc-z0DtKd5Ij_Bi6EvlYg>
 <xmx:enbBaP1jUdaH3CB49TK5p5-loXR6V5jR8LoMlCDt5zde4Ieq_ZTB5w>
 <xmx:enbBaJQH333dR7I5y-QoYY_fAm60DxffL3bljHol4D1eSoGdTEY6t6b_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 09:00:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, bruce.richardson@intel.com,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v3 3/3] bbdev: fix build with MinGW 13
Date: Wed, 10 Sep 2025 15:00:40 +0200
Message-ID: <4675976.LvFx2qVVIh@thomas>
In-Reply-To: <20250908212034.699713-4-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20250908212034.699713-1-thomas@monjalon.net>
 <20250908212034.699713-4-thomas@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

08/09/2025 23:17, Thomas Monjalon:
> +               const char *status_str = rte_bbdev_enqueue_status_str(i);
> +               if (status_str == NULL)
> +                       continue;
>                 if (q_data->queue_stats.enqueue_status_count[i] > 0)
>                         fprintf(f, "  Enqueue Status Counters %s %" PRIu64 "\n",
> -                                       rte_bbdev_enqueue_status_str(i),
> +                                       status_str,
>                                         q_data->queue_stats.enqueue_status_count[i]);

Coverity is raising another problem in this code,
which was already there:
i should be an enum, not an integer.
I can fix it in the next version.



