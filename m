Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DABACA5FDD
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 16:18:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C0234026C;
	Fri,  2 Oct 2026 18:18:05 +0200 (CEST)
Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com
 [74.125.228.37]) by mails.dpdk.org (Postfix) with ESMTP id 1AA8D4003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 18:18:03 +0200 (CEST)
Received: by mail-pz2-f37.google.com with SMTP id
 d2e1a72fcca58-88732460a36so2066667b3a.2
 for <dev@dpdk.org>; Fri, 02 Oct 2026 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790957883;
 x=1791562683; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+cVh7egO56hOtSoOi707QtFyEyGtfQEbAL8RbsMlhAk=;
 b=rIlvRMmDxZlZaT1xTUL1qhn4WOZ3jO2sLyRPcFY4RLZtJzjgGnVeKoswVDxLyJ3Cyu
 QHeCDlU+UqqnUDEOIFIpZqBYXMOzOOGbP3nxZa29zLAHxcSecHeeYrmQ3fOg7L6x1zwJ
 fDfdUwpyF1GRYWYv94hxgPNpzTtIS1YU0J0S4vdsodnlQ22/UFkWqdEvgarYcXgfMXPa
 8F7pr8G4UbbcXk8mpYbnwL5w/I6iphdBmKBicnBa2eIR7Bra8HfvRJ6XKVgohAxNiG1D
 SbCoDESR6RMz1JDS9EKHMB6KQI4ns5imgo3eyHEmIVqrQ7B0AP+NcKjvnT+7j547a4qv
 O/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790957883; x=1791562683;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+cVh7egO56hOtSoOi707QtFyEyGtfQEbAL8RbsMlhAk=;
 b=e4cY6w5tIPVhrLoTsT+mbg4MYvv9+5TRKYd8n97Bpp12WlG8YoyXBrxEsqcdtg7xj/
 LW+D81EHgHzFOIgVk0hYZUvVeNzlYeZ6QqMEpf/PrfT6BA2LFEIssFG5jku5EHaIqRgM
 8JzADaJgfxlt68fBAlY91plX+i8hYBbK4ZI7HBEWVFA/ms7H59ghOW5db1HCHNxKAuTA
 xWwbHml3HmQqcBQz7pe3xUUPTUu9Wn+3Nh6gTJVJp8nhSVdDj6HKFT54nweNa1J7eJRm
 zl8QIxe42PWCyxKIFiQj8+G+gqryHQgR3NXJMdZzCKMfhrnuRZxxBId+m3zC5Tr9+fGc
 Z1pw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOJ3LqYGLvjA6AgRhQ+jVA2qs+jSDTIxu0ixZ98Se19wfI8l9s8BpAZv4dvtN0GIOhi30=@dpdk.org
X-Gm-Message-State: AFuF++knQnkIbkzU0xVMpJUHHryFhseM2ZAYePXKd7KzlRrqLvIAmDPd
 CfmD9StXqMrG4tpc5A5PANU8vN2APn9xMDt1P8hqrz5gBb5mgl1Sfn3TGSLy2olMneM=
X-Gm-Gg: AYBFou0mSTRKaioVEqvLd7D1Y/+fwF8zbfVHuX+bnXuVKb7TJ9PBV44IKb38SN4ig7C
 86kd/oXQM9VtZsAQtNv0EWxAyQPQI0G5DVsDu+9UVSVnNZ4JT5ZSpyuTXXIs4+30Gx1BK+1njt9
 PfLqZ1mDMfJ6IdAlF7cILiSoCYKBxJc6cga3eDsq2KqaSCL5GRtWTVyQJRzNSDiutK6wF5Co1wi
 O1mrhi5A/Al4NQU2P42aYxaDpUrCVW9A4bNv/TyAceHlD/jVsj/00JEYwgqhLUmzQYR8uJ5mcvE
 GfsdVS+ajMe48jhtuaE5lwzN11gomeOJsVuA8gq4/fN4AgmcRgPxvkf//b2oDvfIrnZM98zR8ou
 64uQ0dRJM5y10SGugbVokpdM18lWwYzyZFdk3pQAmSM39LR/1Gp2LYSo40AtDfkqMmgxWWrpFgy
 Hg9toJ988Gk3QlhTGyEZYDML7opLx/tfnHmGIe4y2wKBC+tgJ1q0cVX2+2Yzo3wzeTPCaglJZqp
 Nm1ff7FqfH5wFyGNOs8ys+QrlMtrpNlXnp/EgvJ
X-Received: by 2002:a05:6a00:23c2:b0:878:37b2:df9d with SMTP id
 d2e1a72fcca58-88af894fecfmr3248145b3a.55.1790957882534; 
 Fri, 02 Oct 2026 09:18:02 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-88b0c3a3003sm1157155b3a.29.2026.10.02.09.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 09:18:02 -0700 (PDT)
Date: Fri, 2 Oct 2026 09:17:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v19 00/26] NXP DPAA driver enhancements and fixes
Message-ID: <20261002091755.766e205f@phoenix.local>
In-Reply-To: <20261001112430.251845-1-hemant.agrawal@nxp.com>
References: <20260930062437.3019096-1-hemant.agrawal@nxp.com>
 <20261001112430.251845-1-hemant.agrawal@nxp.com>
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

On Thu,  1 Oct 2026 16:54:04 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of fixes and enhancements for the NXP DPAA
> bus, mempool, dma, crypto and net drivers targeting 26.11.
> 
> It includes memory-leak and resource-cleanup fixes on the device
> remove/close paths, more robust frame queue and congestion-group
> shutdown, secondary-process safety guards, BPID and cgrid lifecycle
> handling, and several new features: offline (O/H) port device support,
> enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> configuration via devargs, Rx/Tx taildrop threshold devargs, non
> fmX-macY shared Ethernet naming, and DMA scatter-gather and
> errata-workaround devargs. Documentation and release notes are updated
> accordingly.
> 
> v19: 
> 	addressed AI review comments


No blockers, but there are still some things which are worth addressing.
I demangled what AI was trying to say but still seems confuzuled

Patch 10/26: The new qman_pending_fq_by_cgrid_range() can check a
  whole range of CGRIDs in one scan of the FQID space, but the series
  never uses it that way.

  dpaa_eth_dev_close() loops over every Rx and Tx CGR and calls
  dpaa_cgr_stale_fq_cleanup() for each one.  That calls
  qman_pending_fq_by_cgrid(), which is the range function with a
  range of one CGRID.  So closing a port still scans the full FQID
  space nb_rx_queues + MAX_DPAA_CORES times.

  The Rx CGRIDs are contiguous, and so are the Tx CGRIDs; close
  already releases them with qman_release_cgrid_range().  Make
  dpaa_cgr_stale_fq_cleanup() take a CGRID range, call it once for
  the Rx set and once for the Tx set, then delete the CGRs.  If that
  is not wanted, drop qman_pending_fq_by_cgrid_range() and its
  RTE_EXPORT_INTERNAL_SYMBOL, since nothing outside bus/dpaa uses it.

Patch 24/26 Symbol defined but never used.
 $ git grep rte_dpaa_bus_oldev_enabled
drivers/bus/dpaa/bus_dpaa_driver.h:int rte_dpaa_bus_oldev_enabled(void);
drivers/bus/dpaa/dpaa_bus.c:RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_bus_oldev_enabled)
drivers/bus/dpaa/dpaa_bus.c:rte_dpaa_bus_oldev_enabled(void)

* Missing doxygen
  - rte_pmd_dpaa_oldev.h is not in doc/api/doxy-api-index.md.

3. New functions should be in release note.


Pre-existing, not introduced here: in dpaa_dev_init() the "FMC
initializes failed" path does goto free_rx without setting ret, so
probe can succeed with no Rx queues
