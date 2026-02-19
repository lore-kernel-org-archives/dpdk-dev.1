Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265BFE9A05A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 19:08:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41183402C6;
	Thu, 19 Feb 2026 20:08:58 +0100 (CET)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 840E3402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 20:08:57 +0100 (CET)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8c711959442so168321885a.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 11:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771528137;
 x=1772132937; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2nkVXe6ACHv/yeXJ+unwad64Gp1ayDU7PqJMdKjpQ8=;
 b=JjMBSetv79UjA7nLGmB+6F3AIRGi3ScHNa/HjeVgvoTVjgIKE19+y689l1uwJhICmb
 E1EDhQ9hTG7jhB1UsQd/NlL1t1++Be0VUO3p7yWkIayeib/GX5Jkc/HXM+wl5MaA4y4x
 2+CO63Vd34hfTbJjLryJjHA/NH4uHrM1qh50YhxjfU+lLZs0L5YVt+w3H1apGKANyRDA
 aoQqncK9cXHUKlpeR0iGJpE3FOE1FC4C4F9azjf/gU8CskBktwvhgykicPHoRuyaN4T0
 4U1W1KwW4hH0Slm12aIt0IHHjNCKAzb1K0X5nrDynt83XThPkflY97a334LWxO1rJ/tl
 IOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528137; x=1772132937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I2nkVXe6ACHv/yeXJ+unwad64Gp1ayDU7PqJMdKjpQ8=;
 b=Qa5LvP2F4YGtOu2dyt02EVJCMySU1OL9AhSbGyrTpqm7x17dIEMR1qy5Z6/bbtgZjp
 vxWF2ZPzWGQDVxKETMXWHPiI/W/pq3c+qe2iitr8+fc4Y2y9qLb5ZTeKPEyzyB3iCzbt
 gQ4ukfwrIkaExR06dg4dwTpJ6haVJ8yOZreCZN9LTKEeSlTkA9K0KgK0rV1TSsklegyp
 IltsXZ7sqqDs507N/AWSaUc+AuJ8OgG8Gc2qQDGHtj2iGWwcuVb08XuI3ZYsrLdWiH9/
 9CyTXadHy70O+1pm5gEGuv2Sk9h7VELJimCA41Ynz5TbHSQ2nwYatUQcQVkKGpvZuUYn
 jlww==
X-Gm-Message-State: AOJu0YyEoZCuC6TcdFTY3VDAWZTbgRFqPzMk/Awd7BNWNaC9x9BEEu4P
 Vc4PcsUPW0b4u1gwk02vJn+V1DJcjJllUSAyLNolbahFYPLuHa8c4Ryu6hUJ/B5bDrE=
X-Gm-Gg: AZuq6aK5/5A5MA9tf3vGKfDdzHHXb/DrPH3h1f4GQNsKuaY6wRbK0uArQQJmwqPqmsR
 ZYy4+qMJ4GWBct9EDl3Gg1eyyF2c5lqPZpX6EfMJQtDuFFJmOt0j1dL3cThuE2gkNaACVmm++tw
 BdLOEMRzAOqj44BmIhTTqgypREIg8dErgj241X0aeF1Ec4QluvyqkZlP6k4PfBEhjslUUyamIhb
 k5aDlnNcR2ytA5SfrcTkLfIpFDBdI4Hx1quPQ+lagfMH63GJttfFFjwue63c/tJebpmMvwaIYcO
 7+VhXAiMIa/Xnq/rZHV+sV1mkh44obDMoulOB1D0FK02SijLshIgfcmb4fEiIhffnRrJuZ4OIh5
 WiQpOxj+/7Zc1E+Zq2y8rOgRLE3rLefp5rcip8PuiQVUNKhOmjYQT++QTTsShplVFB4a2YC8MT+
 /P6ZCKvHeKCfr4C2gILCqXYzRKYT5J3JLSqbc/BYxL5nC5AbbEw7Hu4k0/ldCCWlA6
X-Received: by 2002:a05:620a:1995:b0:883:647b:6dec with SMTP id
 af79cd13be357-8cb7be3b716mr325431385a.3.1771528136706; 
 Thu, 19 Feb 2026 11:08:56 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b1c7e71sm2339312385a.30.2026.02.19.11.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 11:08:56 -0800 (PST)
Date: Thu, 19 Feb 2026 11:08:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 00/27] Cleanups for ixgbe, i40e, iavf, and ice PMD's
Message-ID: <20260219110853.3852de22@phoenix.local>
In-Reply-To: <cover.1771518103.git.anatoly.burakov@intel.com>
References: <cover.1770646012.git.anatoly.burakov@intel.com>
 <cover.1771518103.git.anatoly.burakov@intel.com>
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

On Thu, 19 Feb 2026 16:22:43 +0000
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> This patchset is an assortment of cleanups for ixgbe, i40e, iavf, and ice PMD.

AI review had some observations here:

Patch 20/27: net/iavf: avoid rte malloc in MAC address operations

in_args_size is always sizeof(list_req) (full 64-entry struct) regardless of how many addresses are populated. The old code computed an exact-fit length. Probably harmless since num_elements governs PF-side parsing, but worth verifying.

Patch 21/27: net/iavf: avoid rte malloc in IPsec operations

Pre-existing: iavf_ipsec_crypto_status_get() response struct uses struct virtchnl_ipsec_cap but the function reads ipsec_status. The old code had the same mismatch. Since you're refactoring this function, consider fixing the response type to struct virtchnl_ipsec_status.

Patch 23/27: net/iavf: avoid rte malloc in irq map config

iavf_config_irq_map_lv_chunk(): double-offset bug. The loop runs for (i = chunk_start; i < chunk_end; i++) but then indexes map_info->qv_maps[i] (should be [i - chunk_start]) and vf->qv_map[chunk_start + i] (should be [i]). For the second chunk, this writes past the local array and reads the wrong qv_map entries.
iavf_config_irq_map(): the num_vectors counting via if (vmi > max_vmi) only works if vector IDs are assigned in monotonically increasing order across the queue iteration. If not (e.g., round-robin where a lower vmi appears after a higher one), the count will be too low. The old code simply used vf->nb_msix which is always correct.
