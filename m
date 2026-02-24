Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33099F3C986
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 14:41:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32B6040270;
	Tue, 24 Feb 2026 15:41:16 +0100 (CET)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 1E235400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 15:41:14 +0100 (CET)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-89503a3bb83so40239946d6.1
 for <dev@dpdk.org>; Tue, 24 Feb 2026 06:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771944074;
 x=1772548874; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvPgKUIQ8hnrndiNiRtIiR6cVHrYLfrnnAt0wYANqTw=;
 b=wkYdGGFZnaRmN70D6AOhSZV63/iJWiEamSgZRY3lcJBmdPeqWRfUyRCgM1kpJFjJkN
 8IGW5DccowI3FM8Lz+829DDb2399qDb0ZqmlUmjFrJQJeY/IzKH/kEqeSH4XIC1nigTk
 vnOJOyAr57SjSn0A2LYnYaU2TG1ir5S8X81V8NkM24hqGdEpcETpWeiYmONNAy9NEWRg
 dK69KX3nefypBTlAr7v5atX7OWdZss1CK2KAkK99DS5oO08JY93P4k5GkcgEUoMS/ATw
 lbrARPdzVwF51VqkLDGRhpCDhfM9SVCxigpAztgknzIfvYeGH/Pn/EFZ3IoDSMLH+GQb
 bxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944074; x=1772548874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MvPgKUIQ8hnrndiNiRtIiR6cVHrYLfrnnAt0wYANqTw=;
 b=xC1h8n9zAnuRNn+0Od+WuG6o4G2J9+VDivuKKaTjBJBQ6jC1d6uVBCHbLPQVgK0pcI
 ZJhWp6DzUiNUwgvgxqHJAInL6ntDABqHSJvIUjk5jkl21tTXYkovYvknpr22kNOaJN4p
 HZVTV+Ja7towTUVi1b+Gybj+mRivxSIilaCuoEHqyA/KJ1lM036HwCT/VHvEqrC3+DKK
 6A/NKUG7EGozBLnIHLZ4Z53F/BbFxKFRveAA34UNtHKp535fxu1J8cCXu4k9+oq6CjuP
 lG6YdGYHZM0Jtk8zKcJP4qb56D89vliPLAvtLnU2hmgipyVDmjabzp6RHKwwbTb0vhPQ
 4zHQ==
X-Gm-Message-State: AOJu0YwHtg9PYHaGKfave8vfVDhEEfTrbEJaD5B3xYaT+X3nL4r7A2Vx
 qwAcXcTWhDPPUSISVvxXmFJMw2bRt6bb/8ifVL2mipMw3TWGSUY+HybSGqOl7vY2YnY=
X-Gm-Gg: ATEYQzyuAC5Y7J5TH9XmY+6j1NVUB9ofMZWMRX/qCsIvRRJC0nQpRzYxlk0yWM+TAWd
 jJkfiaN8+nPmNXSu40+evJYQLf7lQAETQ+HUQeRwakjR4EeiwAqmoykkWdW9y+TBJW8r04MlK6M
 MbfF4Qn6Z6rTbqNXd30LvTZLRK3wnL3qFXIEbfnnGr12lpedMZXImME62RP8msummmC+RZzcRZT
 2GXPsHIuCZsfpXsoX595001JuGcc5mcvwMMxj7mwCh7LTjJz6yKhz8imX4DpM4LOafNc0SUawlo
 YsFIpijkHdbG0jUnPdwztiLe4iLmieU32+Z0mWis22A33ZPQ3BguIXX3eyhsdbpMNwzlbzv7qjp
 KCjxeLAz39/BQMo26okZPc6biSoH9MdorecdTxmH2yTMp/yrdjzaxsAD9TVluOSm9A1IfjOjjqr
 WRZKS3KoMRBr1jILDovbaI/0pSiz42D/lwkG76ZE4hx8UXe5o4FRA07fJJ5sqogpEc
X-Received: by 2002:a05:6214:ac3:b0:88a:41d9:23ac with SMTP id
 6a1803df08f44-89979d38126mr190133226d6.36.1771944074081; 
 Tue, 24 Feb 2026 06:41:14 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8997e62f453sm97995196d6.36.2026.02.24.06.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:41:13 -0800 (PST)
Date: Tue, 24 Feb 2026 06:41:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [RFC] net/vdev_netvsc: disable auto-detection by default
Message-ID: <20260224064110.1d65ef69@phoenix.local>
In-Reply-To: <CAJFAV8z0oo6zUdfYJDPJe8pJCkpZ4WVyABn0Xq1=EN=s+6givA@mail.gmail.com>
References: <20260224014259.443846-1-stephen@networkplumber.org>
 <CAJFAV8yNsWO7pFH3B4-Wce=XBMNA3N4t__YL7nDpKNeojV2Dtg@mail.gmail.com>
 <CAJFAV8z0oo6zUdfYJDPJe8pJCkpZ4WVyABn0Xq1=EN=s+6givA@mail.gmail.com>
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

On Tue, 24 Feb 2026 08:58:45 +0100
David Marchand <david.marchand@redhat.com> wrote:

> On Tue, 24 Feb 2026 at 08:41, David Marchand <david.marchand@redhat.com> wrote:
> >
> > On Tue, 24 Feb 2026 at 02:43, Stephen Hemminger
> > <stephen@networkplumber.org> wrote:  
> > >
> > > The vdev_netvsc driver auto-injects itself on Hyper-V via an
> > > RTE_INIT constructor. This interferes with tests on github actions
> > > which uses Azure where the driver probes in forked subprocesses
> > > and crashes on uninitialized interrupt instances.
> > >
> > > Guard the auto-detection behind RTE_LIBRTE_VDEV_NETVSC_AUTO
> > > (disabled by default). The driver must now be explicitly
> > > requested with --vdev=net_vdev_netvsc.
> > >
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> >
> > The failure in GHA can be avoided with a simpler:
> > https://patchwork.dpdk.org/project/dpdk/patch/20260223155603.3651641-1-david.marchand@redhat.com/  
> 
> After rerunning with debug, the vdev netvsc is still probed, but is
> not at fault for the recent failures we saw.
> 
> VMBUS_BUS: vmbus_probe_one_driver(): VMBUS device
> 7c1e52d8-3f86-7c1e-52d8-3f867c1e52d8 on NUMA socket -1
> VMBUS_BUS: rte_vmbus_map_device(): Not managed by UIO driver, skipped
> VDEV_BUS: vdev_probe_all_drivers(): Search driver to probe device net_ring0
> VDEV_BUS: vdev_probe_all_drivers(): Search driver to probe device
> net_vdev_netvsc
> DPAA2_BUS: fslmc_vfio_close_group: Get fd by name((null)) failed(-19)
> DPAA2_BUS: Unable to close devices -19
> DPAA_BUS: dpaa_bus_cleanup():  >>
> DPAA_BUS: Portal already cleaned
> DPAA_BUS: dpaa_bus_cleanup(): Bus cleanup done
> Calling recursive action for test_invalid_vdev_flag
> Returned from recursive action for test_invalid_vdev_flag with 0
> Cleaning up /home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
> /home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance returning 0
> Test OK
> RTE>>  

The DPAA_BUS looks like noise.
And also VMBUS.

Maybe we need a --no-bus flag that shuts off all buses?

