Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C611606A31F
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=LPvd7COY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E559940608;
	Wed, 21 Oct 2026 19:42:39 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id DE3B1402D6
 for <dev@dpdk.org>; Wed, 21 Oct 2026 19:42:38 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3ab868eb9cfso552456a91.0
 for <dev@dpdk.org>; Wed, 21 Oct 2026 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792604558;
 x=1793209358; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YbxxLhKHFi7HHL1rX2xvmoi6o08EC6OCybnBHJTFjP4=;
 b=LPvd7COYjTLA1qPAIROypu7hBzBKVNfrMiC1AXrMPltKdRaBwHJE6sysQyck5TEOOu
 De2Zd9i/cuoiOPxwu8jC0qq6dRapsM+xeIx4txFuPDp+QSARWHbbBurnebjrt6NABMj4
 b7BI7+iyFqOF3t25zbmOjhVXw/hprEeLtO9q9kZRbDpOr9nbETrcBr70OkZ8utiDT5jz
 /BIMMPWAnS1ln21hyyynjWZ7XwCv4+lUKWKM1KWBBoGN2aW0/GIbXzlnMaAlQyoRaZ8Y
 W0NbbXRqi0KKyKrA0UEG9OaI5oMN0gJfe7wxh15ADpqHpGPPcWFhiaf2DrOXQjfajr+z
 6WTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792604558; x=1793209358;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YbxxLhKHFi7HHL1rX2xvmoi6o08EC6OCybnBHJTFjP4=;
 b=J6MocP5qtaluEqO++k4ExQfg8Vo8pIEbG7mtQKy5s6iUQ+Krm4iBckjniF4CmoqILd
 ww1b34mx7Fr0SPVDm/VeQqFlKlAy6eEBeBlmh4hVJxICrvqrWA0V3FWpGaWtrviEKUxY
 mUVAfcdwShsJ9IiMmj2vwGpPriX4Amn09N0ySlLK7piziorPAo0BZ0WmmBTTgeZZ8A2Q
 C555qhvGmQmEV7tDb3vYipAHaTCYBLjoEvoY7hcNROAPdZ+duNUlAenTZIfQK0Y1HQKS
 RwPdZ+B/3j1AniWnDwUFgX3vUsHhXdtFBHmNldmJePOgSpQUc0J/QOWcSHRkPHZ1seNF
 J3dw==
X-Gm-Message-State: AFq9FYJrJjJETkyqTr4mgh19R4NLtBwYxCVtKL3NhfV+m4KYXA+yl8XR
 6j718CFIZ6pceV72DxbBU7EgSUC4wmYUimM7rfuipQYu2XM3jd372oHhfQyhkTVTJk3tlw0A2CL
 JQG3W
X-Gm-Gg: AYBFou1yi2d29ElKOCDGCvm5ZQPP119YdeCV9vg4GJ+WuA+L7oc3sJASWMyH+yfiVP1
 MFmvyz2d9em0niQ+dKQ7dZpr0MdSLucChSVJ4ih0wyE/mm6ppypRczJzNfKckutQWyXnjs9Eo+1
 OZbAIxto4qsN+IVB8QnQkNJdOuXi0c4ehR3c/VCOY6XoLgl5FKIK/6jEPWGRTuTwp0uiR62gHFP
 /WaPz9EznG7vQTCcZnqOZWlHHwnT4+RjEsP8gFc4ayRyxgS4FH4Kd6LWeO8VAW8ZXkZgUnucOAV
 5B3UCYrgX/EmyxHOGGALkJJCFY5ZegAELilBzYmMQ/I92uFwgX+xqpMDl24uPThmcI8f/OTlCMd
 XSx1pLkvIcRoIGpWfeyKrfe3vDS/2lUzfAg5rl2IHAjBrK/cq2fMBaBvSHNSLUrdt42ZIvUbBCP
 rHT/9mdl+hDAgDKitKZ+XNizsalJ8mBqFm7sFzbHUxtE2pRdu7VHJMYD/MBfGB3+K47IHRS+K2C
 5QoYhkOdyNb36O2rD2g0Rey/uLVcRlXOhLlsvP+KiWxVTovh5/BStCQJSLLEWaJE6m/x0B9vTAS
 O6a9Ehz/Ep2fLd4ZzQJCGg==
X-Received: by 2002:a17:90b:3a43:b0:3ac:9c37:9429 with SMTP id
 98e67ed59e1d1-3ad86f1b5f7mr2531776a91.52.1792604557599; 
 Wed, 21 Oct 2026 10:42:37 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48a63e7sm431270a91.11.2026.10.21.10.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:42:37 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:42:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net
Subject: Re: [PATCH v2 00/12] Validate multiqueue configuration in ethdev
Message-ID: <20261021104234.2d877fac@phoenix.local>
In-Reply-To: <20261021103027.2050351-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 12:30:14 +0200
David Marchand <david.marchand@redhat.com> wrote:

> We have various checks in drivers about Rx and Tx multiqueue
> configuration.
> This series is a followup of the VMDq cleanup, finishing the job with
> DCB and RSS, and then rejecting invalid multiqueue configuration (useful
> from an ABI point of view).
> 
> Some drivers misreported their capabilities.
> It is important drivers maintainers review carefully those changes.


AI review 

Review: [PATCH v2 00/12] ethdev multi-queue mode validation

Applied cleanly on main (0e03411639). Every commit builds with
-Dwerror=true for all touched drivers except mvneta/mvpp2 (no musdk),
plus the touched apps and examples (ntb not buildable here).
check-doc-vs-code.sh full mode is clean at every commit.

v1 items addressed: ERE alternation (01/12), intel drivers covered
(03/12), igb/ipn3ke docs (08/12), RSS rejection limited to more than
one Rx queue with examples fixed (11/12), xsc hash types (10/12),
idpf/cpfl hash_key_size/reta_size (10/12), bnxt pool (04/12).

Remaining problem: incremental mode of the doc check is broken by
03/12.


Patch 03/12 devtools: handle multiple drivers in doc check

Error: the top-level doc_code_map loop assigns the global "drivers"
variable, which changed_net_drivers() uses as its cache:

	[ -n "$drivers" ] ||
		drivers=$(changed_files | ...)

After the loop "drivers" holds the last shared-directory list
(" txgbe"), so with a trusted commit only txgbe is ever checked.
Reproduced on top of 12/12 by adding "VMDq = Y" to mlx5.ini:

  devtools/check-doc-vs-code.sh HEAD~1   -> rc=0, nothing reported
  devtools/check-doc-vs-code.sh          -> VMDq documented but
                                            max_vmdq_pools not set
                                            for mlx5

Use names that do not collide with the script globals:

	for d in $rootdir/doc/guides/nics/features/*.ini; do
		name=$(basename "$d" .ini)
		dir=$(driver_code_dir $name)
		case $doc_code_map in
		*,$dir:*)
			before=${doc_code_map%,$dir:*}
			after=${doc_code_map#*,$dir:}
			list=${after%%,*}
			rest=${after#*,}
			doc_code_map="$before,$dir:$list $name,$rest" ;;
		*)
			doc_code_map="$doc_code_map$dir: $name," ;;
		esac
	done

With only "drivers" renamed, the mlx5 case is reported in incremental
mode as well.

Info: driver_code_dir() hardcodes the list of intel drivers. Testing
the directory picks up new ones without editing the script:

	*)
		if [ -d $rootdir/drivers/net/intel/$drv ]; then
			echo "$rootdir/drivers/net/intel/$drv"
		else
			echo "$rootdir/drivers/net/$drv"
		fi ;;


Patch 11/12 ethdev: check RSS availability

Warning: the commit message and release note say RSS mode is rejected
when flow_type_rss_offloads is 0. The code rejects it only with more
than one Rx queue; with one queue it logs a notice and clears
RTE_ETH_MQ_RX_RSS_FLAG in dev->data->dev_conf. Say so:

  * RSS mode (Rx ``RTE_ETH_MQ_RX_RSS_FLAG``) is rejected with more than
    one Rx queue if the driver reports no ``flow_type_rss_offloads``,
    and ignored with a single Rx queue.


Patches 05/12, 10/12

Info: Fixes: targets are in released versions and there is still no
Cc: stable@dpdk.org. If these are not meant for stable (the fm10k hunk
relies on the ethdev VMDq check), say so in the commit message.
