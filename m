Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EC1CCD192
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:46:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 871F240E19;
	Wed, 15 Oct 2025 14:46:01 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id B4A68402DB
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:45:59 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id A8DA91D0014C;
 Wed, 15 Oct 2025 08:45:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 15 Oct 2025 08:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760532358;
 x=1760618758; bh=l/hUdcrInkozvn7WELAPudOIZ+enX8lmuMO4C3jCQCM=; b=
 P5EocdvWWjIIalUbk5S7GaTg0lbjQLP1w/Nr4SLjN2cRiIqdU5sby0RO5HLzk31d
 YGvEQThLtvwzYkc7aa9l4WLjife1eSRZZvPNKhpbmbCj1giQd8ag4GWJNY+ojfKa
 iKtkYVJQYkbB7g7in4pT43PpIbyNVe5lb0NilzzF6d2yGWoVFEU82Tf0DVrRa+lV
 QjsDM25IUrpl81a92xYQ4RbdjT4FsHP7Le/wHkIsYwAF+P2D9JIS/FXkKUY/p5bB
 z/CJgIhgtGsUougi8uMUpad2XSry0YRTfsTkqH+bZcVl1e00kGwbTHHwMM1QNzGL
 75/crvHojoLaDLaBnpAyYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760532358; x=
 1760618758; bh=l/hUdcrInkozvn7WELAPudOIZ+enX8lmuMO4C3jCQCM=; b=s
 w7uYfdlSxLYow53uklZtqrA6xeAnOiKod40i5shLJDZBzZhpAPqkS5oWBsdVmPoQ
 Ja82CP1SvHmDiOL0FsGYB4HFwNMnGRb2DqMAidMeTTPsLRiAiKDr3vyWxUpQsMG5
 wuq0U6KNPlXoQZQ+KIHLr2KtFCwaRFk7NAf8zbMoHFUDVzWh2MutCt3DUWPJ501p
 EWdabS5zPDx332AURA9LUv4Rfs/q8wm+NTgYO+mYIhiwJ22yUfhcOFnoHNVlP2ea
 9tBzf7j4VqanY0mhZvTUH+ck3tX2y7b7tSQvIuV0Z4ouK91C2kxV0sYt1zv+CRTq
 iToMb3EkXRDzwm7+pYRGA==
X-ME-Sender: <xms:hZfvaLW2EYpF1k7XwW2GLyMvWESMx7TPDL1_cNWVa0mqu7Ve6afM5Q>
 <xme:hZfvaKdPujMbye8le1fjHExycStlqAScM7oUft_qcuM5mJDAsWyh3znf-OjgVt3K4
 qzVPYhHBvDqgX--VEnVnm8sloNT66CX-khr_ZPb71n1_ebdFFYuIg>
X-ME-Received: <xmr:hZfvaPuG6kwmOypZQaMDkXn8VVz4Y6UWIDLf2XQrg8JvNRUB7RnC8hcV31VS-uXGOI9ihF1wcB700rCfWMZxBOzDYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefgeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtth
 hopegrnhgurhgvmhhuvgeslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphht
 thhopegrmhgrnhdruggvvghprdhsihhnghhhsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:hZfvaB8lJhQelYFRISDMUDNdLuWnGH7Aqmedxh4GRyYXgsS-GMpJRA>
 <xmx:hZfvaC1lQSnIW5FwhVIPLXsvh50HfzxgF1AHjWLXm-imu3-Spw1i0A>
 <xmx:hZfvaODbNqEA2sxzNMxuXDgzTQlGcd6Leso7V5xRQqUf90BuNFgxyQ>
 <xmx:hZfvaGcmoDa6QQpfl72uNNrfedJBs0vTH5XyYgB1bZ4xjM5keabeXg>
 <xmx:hpfvaOVq0Zda90nRFeMtxboMvnq_m-bQshNAMwRrm2clB4IgNFxKTxu7>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 08:45:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, andremue@linux.microsoft.com,
 Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v4 2/4] app/testpmd: explicitly set command echoing on
 file load
Date: Wed, 15 Oct 2025 14:45:55 +0200
Message-ID: <2863857.3ZeAukHxDK@thomas>
In-Reply-To: <20250731160041.914837-3-bruce.richardson@intel.com>
References: <20250704140551.4151993-1-bruce.richardson@intel.com>
 <20250731160041.914837-1-bruce.richardson@intel.com>
 <20250731160041.914837-3-bruce.richardson@intel.com>
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

31/07/2025 18:00, Bruce Richardson:
> The echoing of commands contained in a file loaded via the "load"
> command on testpmd CLI is governed by whether or not a cmdline-file or
> cmdline-file-noecho had been passed to testpmd on the commandline.
> 
> Remove the use of a global setting for this, and explicitly add a
> "load_echo" command to match the "load" command.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
[...]
> @@ -11646,7 +11646,9 @@ cmd_load_from_file_parsed(
>  {
>  	struct cmd_cmdfile_result *res = parsed_result;
>  
> -	cmdline_read_from_file(res->filename);
> +	if (cmdline_read_from_file(res->filename, false) != 0) {
> +		fprintf(stderr, "Failed to load commands from file: %s\n", res->filename);
> +	}
>  }
> +static void
> +cmd_load_echo_file_parsed(
> +	void *parsed_result,
> +	__rte_unused struct cmdline *cl,
> +	__rte_unused void *data)
> +{
> +	struct cmd_load_echo_result *res = parsed_result;
> +
> +	if (cmdline_read_from_file(res->filename, true) != 0)
> +		fprintf(stderr, "Failed to load commands from file: %s\n", res->filename);
> +}

These 2 functions cmd_load_from_file_parsed()
and cmd_load_echo_file_parsed() could be merged
in a single function by passing the echo boolean as callback data.


