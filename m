Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF111C982E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 16:20:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0345242E60;
	Mon, 21 Sep 2026 18:20:55 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id A65F742E48
 for <dev@dpdk.org>; Mon, 21 Sep 2026 18:20:53 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747ec6188so20526915ad.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790007653;
 x=1790612453; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vJ70y81uZ7n2j67d29YyLMDV95+qIeTh/OKLRRV5lZ8=;
 b=xTx/rdV/Pw3Gi/otI97wJ5vTy5aRzPJ+tZlRO86fo6WPXhPVtyiC1Jx3hEgYXwc7iT
 fucnLztq3dowbktKU/h621uUwYvaWDK1yA2oQ+/CitWVfiA2j51nyv0TNciVtN9zPEVu
 x3KlhBNo2/bC63b8YGfX2vc7jM8lIf1lzd0Jxi0wNURZFEaxXThtxOr1L52aha73yVnZ
 VihWrycehWIDQAuVfRoqMB6yixu/ACwKubtsnQ/OxIizGxq33NtmOmYPLrW8hQkLipOd
 b8MOi0HweKZSo2jyGPuQhA6B1cnDMEwDKKWLX+jcxGZwPquX/vsRIWAWbKs3Hyz7L5tM
 euGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790007653; x=1790612453;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vJ70y81uZ7n2j67d29YyLMDV95+qIeTh/OKLRRV5lZ8=;
 b=ml6B46nh6QLQPHnphshnF2a71WGNWROQLFcnwk9+ILrbiRz7jML2v1iFflM4KjLYMt
 N1gQ5Ms+FPgzsJ34dudXvZqr5p79HeJsQnDuL+g/RjaI0lH8A9MV4Lve0vl+C2MUCu0R
 kGqYgGnprjnzvEUQfcJ3g8hrj2B/PlNV+e17teJ2CRM+MNlNOaDYFky0X70bP8bvNtWF
 1jCoLhzVSFFXWECYExXT+phcAZpp0fBu+yi5k5nzmwQK1LECHrrgoptftflmmgGGdD5K
 iePzAB3ADCuKmyftDWd2WCedXRsP3gh5i0RnEjPX11UlQwpBp8PQiDFSLTBMBhfUGevn
 1bew==
X-Gm-Message-State: AFuF++k8tqQYuOQNTLHDCfJ/6pL6O2WTUQxDZ/GCXuRkMpO7NciwGBZJ
 yQCcrHZPxAwzOJ3kOWw7gFptafQDj8RJINgeY8KMigCfeE/hMsNNgDgj3JkGpYdn9SM=
X-Gm-Gg: AYBFou27RwSALoD8Eri9Pj1ALk+6kayzlRQxAb1j2TIGhhkByT13RNqQq5AnXcFW8ps
 VMhCA040fHHwZKdXvO7UPqZMEJXZTM42xPqVsMeKM5091CusjORX3PwB9pSYX5b2yP8Q8fTrjG1
 VSSOExgn2oTg1J7LyHk3Esp2+zGRr7eYC/zgO6YZIPzgRaQC7UZ2fnqKiTQgNuF+gC4vV0kWGUu
 KTAApBlVBDH+VV1h0tSU9Mv9soreiZe9Ywxs6Bi8+xZgAS6ebIGsVtJ4eA7xdvokVeJl08qZNPk
 fidAYJwfwnhCTN2VJE85e63oZxCUfqngCwjSXlGaiq2HlUexJ1lpqxjXPWa0kySLqqR53ZA4faF
 M4TibfS3RGpPYtYPs2iNQoS9dkVztTMQvJbGibGnSaoNiv8sCVC8R8gVvOx7VdxlHDHyLx0w0oj
 I/4AV1nmXX7SEjdCizU6NPg2zJhnlr2T81poXDSJbTxVKVYuohx6RvxsvT5rxSxzJuKXEa5LIUb
 z7mm23e1o2Jils49rHcVjcfDi2Da2rzEPDuZjcB
X-Received: by 2002:a17:903:234d:b0:2da:e967:7953 with SMTP id
 d9443c01a7336-2ddb1b0d343mr169743165ad.12.1790007652669; 
 Mon, 21 Sep 2026 09:20:52 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df3ae73eb9sm27413365ad.44.2026.09.21.09.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:20:52 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:19:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, Keegan Freyhof
 <keegan.freyhof@broadcom.com>
Subject: Re: [PATCH] net/bnxt: remove VMDq support
Message-ID: <20260921091932.39fa0013@phoenix.local>
In-Reply-To: <20260921030811.1034869-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260921030811.1034869-1-Mohammad-Shuab.Siddique@broadcom.com>
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

On Sun, 20 Sep 2026 21:08:11 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> From: Keegan Freyhof <keegan.freyhof@broadcom.com>
> 
> Remove support for the VMDq feature from the driver: the multi-pool
> Rx-queue configuration path in bnxt_mq_rx_configure(), the VMDQ VLAN
> pool wiring in the L2 filter alloc path, and the max_vmdq_pools/
> vmdq_queue_num reporting in dev_info (now always reported as 0).
> 
> Preserved two pieces of logic that live in the same
> function/switch statement but are not VMDq-pool-specific: the
> RTE_ETH_MQ_RX_RSS pools=rx_cosq_cnt case and the
> per-non-default-VNIC skip_filter_allocation guard in
> bnxt_mq_rx_configure(), both used by the plain multi-COS RSS path.
> Also kept the RTE_ETH_VMDQ_ACCEPT_HASH_UC/BROADCAST/MULTICAST ->
> l2_rx_mask flag mapping in rte_pmd_bnxt_set_vf_rxmode(): despite the
> name, those bits are the standard DPDK VF-rxmode API used regardless
> of hardware VMDq pool support, not a VMDq-pool-specific control.
> 
> Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> ---

[PATCH] net/bnxt: remove VMDq support
 
Warning: mq_mode validation is lost. Before, VMDq, DCB and DCB_RSS
modes hit the default case and returned -EINVAL. Now any mode other
than NONE or RSS silently configures a single pool and succeeds.
Reject every other mq_mode explicitly in bnxt_mq_rx_configure() or
dev_configure.
 
