Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B87C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 14:32:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B9E440E37;
	Wed, 28 May 2025 16:32:17 +0200 (CEST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id 60FC840156
 for <dev@dpdk.org>; Wed, 28 May 2025 16:32:15 +0200 (CEST)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso833950466b.0
 for <dev@dpdk.org>; Wed, 28 May 2025 07:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748442735;
 x=1749047535; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Uw2XSPdI+28ZseMy1Rh1l9epEE1dtbgt+IlXGUvsCc=;
 b=IAg5wfurOFLJUkzcSwbl00ZLHhFETOuC+RPjKBbofzpXoFJm6USRZLwfUly03AtM9T
 FzCk+fFMsFbvLTB9vHYJ+1UjFwHZ0AkGK94LqPOrNRRbWSfNgHgXL9YQG4jKJWqhMVef
 YA3f9N2kI5Fn5uFMGUKnOoOjC6s6m8wICNGchNO3X+gIpfOYVwIE7hXAoN/70t9h7W1f
 ICEH1bgU6QVi+z+RoyL2zkc5mZW0fWvE0AawWX9OuIEPSUVi1y0Pe5yoHrFiYVzUKW2B
 PbTtXzdFCJeqqQ0CVEIPsBIuMtWMmAR79vIkCFz3ZYPjPtK9n+VzXcwBnbfJtXRPP9d8
 8vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748442735; x=1749047535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Uw2XSPdI+28ZseMy1Rh1l9epEE1dtbgt+IlXGUvsCc=;
 b=ZGPBBwhH8EMSv09i4zfy7fIZaUg+6OyPhudfF8TbpDR3aJOrn3r5+GYaI72arstdA9
 Kyvvy+puo49dtG1IyB9JzjBEDCdEmjdVhtBqBGHyrMHuNyPYoKUR69HKXZhrFvZ5tEkF
 SdU/ZNCtpEub/8yIdUz68vYcRuw+e2YLWZPPLr45zAZ8MWtVIKZzRlDKhHBFSQgPAwQD
 IM4jrjWMYYDr02/tpgJugNJo/hWrTGYPlw8BRDEzbjJPuSvborQYC/eV79wqhyk0N+u8
 eFJiC4v3hsCQuFgz4JYcQvd9PfQrXpMIEwvOo2fpeCpDvHs9Vr0ehZ40wWp6Lp0jwYgZ
 no2g==
X-Gm-Message-State: AOJu0YzOfs9JFzEsgeZENIjDJXsQ1d6axlxQIsGN1ZfZSVP0fXkrvRN5
 voyoSwvTMCmc+AbFVN6W/LIDmozjX4e0tmF2U9tI9XpWK/FpuClV6kg/jYmK1TJ2eqQ=
X-Gm-Gg: ASbGnctrv3Z3yF63YWWdIayk2k5EXOG8cyfzEkgbFzWetiO9puBgdRWPyNNttmOPn7N
 +SusKpvsXlM8opjzGxA/freyFevWzsRKufl9I7nSJotb0LfqRYeOy0WhgQFRCyY00g1mBUEqkVP
 TtyPTQeGnloMk19S4qIRC484yT66VcIWnkIJvt9Sp+dUogUZFQQd9ekMmS2qHpVQZxDTXMy2qR3
 OQnCBuQ76avyDIu3TXTu4FWvODHj6IHVV71jlTguMR7dcoFhciTbNv+fJA4MZkiwOkRhkYdmHNx
 5W/Iys6pWQH9UPTqU8e9v9vd578Z2dFVhcfPj1sDR1iqK+8rfXMkCih1x+60Y7QH/Jst5x6H2jL
 BFWp501APbzBZ4H2H3LQHNmkrPD/6
X-Google-Smtp-Source: AGHT+IG8nAvXvAkE4o5Dinr0pkeb09JH7Sru5sPisK9W2WguhQOiqC4JXP3mKH3/AbXUOz+roRSPaA==
X-Received: by 2002:a17:907:3ea7:b0:ac6:f3f5:3aa5 with SMTP id
 a640c23a62f3a-ad8a1f0d657mr235955866b.16.1748442734902; 
 Wed, 28 May 2025 07:32:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad8a19c8a45sm115804566b.39.2025.05.28.07.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 07:32:14 -0700 (PDT)
Date: Wed, 28 May 2025 07:28:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: Re: [v1 03/10] bus/dpaa: enhance DPAA SoC version
Message-ID: <20250528072834.451e0043@hermes.local>
In-Reply-To: <20250528103934.1001747-4-vanshika.shukla@nxp.com>
References: <20250528103934.1001747-1-vanshika.shukla@nxp.com>
 <20250528103934.1001747-4-vanshika.shukla@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 28 May 2025 16:09:27 +0530
vanshika.shukla@nxp.com wrote:

> +	if (s_rte_dpaa_bus.bus.conf.scan_mode != RTE_BUS_SCAN_ALLOWLIST)
> +		probe_all = true;
> +
> +	svr_file = fopen(DPAA_SOC_ID_FILE, "r");
> +	if (svr_file) {
> +		if (fscanf(svr_file, "svr:%x", &svr_ver) > 0)
> +			s_rte_dpaa_bus.svr_ver = svr_ver & DPAA_SVR_MASK;
> +		else
> +			s_rte_dpaa_bus.svr_ver = 0;
> +		fclose(svr_file);
> +	} else {
> +		s_rte_dpaa_bus.svr_ver = 0;
> +	}
> +	if (s_rte_dpaa_bus.svr_ver == SVR_LS1046A_FAMILY) {
> +		DPAA_BUS_LOG(NOTICE, "This is LS1046A family SoC.");
> +	} else if (s_rte_dpaa_bus.svr_ver == SVR_LS1043A_FAMILY) {
> +		DPAA_BUS_LOG(NOTICE, "This is LS1043A family SoC.");

Should be INFO not NOTICE, this is normal condition.
