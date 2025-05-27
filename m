Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D892CC54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 15:07:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE7D4402A0;
	Tue, 27 May 2025 17:07:22 +0200 (CEST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50]) by mails.dpdk.org (Postfix) with ESMTP id D5A0B4028D
 for <dev@dpdk.org>; Tue, 27 May 2025 17:07:21 +0200 (CEST)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-72bd5f25ea6so763340a34.1
 for <dev@dpdk.org>; Tue, 27 May 2025 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748358441;
 x=1748963241; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kIQ/mC7x9pwlXWLiRpRo2lpkjoOTcxOwHsx+dub6sMo=;
 b=ZMuhYQv71dd+E1O869IQ/0k3wHWqCa93wGEmFUa/7UWHqG5GqR8hETehSbqmvqGTmj
 jdiY4aLn1vChsUtZgNRPRJhwUnS1qv2jzziP/6DGx+iEG1t10HSnOzXPk5W/Qy/4JJmB
 9OkmF4KsYYHMMEDgqkmPAkMR4PQ4xLNuhrOTFzorAhI1A+pabROMFcRTxLshxuoNgfa3
 GiA1+SEKZe2d27f+XmDMiGlFBFWIk03/QUqpL79jo6D+Sk7HKYW5ViuOKMrf7V43OO92
 FBD9H0Qoh175IeOVO5MLQshppql2PKZGA1c2beSB9D27MUyvmfirzpG3viILjua1drlb
 6vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748358441; x=1748963241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kIQ/mC7x9pwlXWLiRpRo2lpkjoOTcxOwHsx+dub6sMo=;
 b=I6wQlog3ZkV12x6MFL/l0XtNFBGekICWtC2ahDvxBnrhdlwUBZgfFfS6MdzktyuBkZ
 o/1yryJJTolr1moeaLcRaSCc2OlwJQ/34vvhdNKHOG9Bz2pBHZlneqlitv4LfDlSzrdP
 Na0bDzakGbQS4i/tSdzYvDIFjOuqNGupD7xDDF+yZqQtNsMdAKMQx7WvbH4joC05KXzb
 cO+1KhqgiBXn0HDGlGz9nOi9KHGruH/jnnGsc4lbBxH9tzPU+0u0lutPYZygJiOhDrMu
 AFtRaqR6pNxzYUawvPKHMl/wtC/WgxVMRCxXZVz+CtJ6COpj0/eG1ys2Bj+WcSMd/CBB
 9EmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGrYx4Ylkt1k9I1oESanVXR3Q4heDgyxhNVb8QIFDsPyljqJO9ZEEqmcXP/fhBSzhj6lM=@dpdk.org
X-Gm-Message-State: AOJu0YwMNF15SGOcXM0zfi/2mDkizT6eamI8STX2lGnO3nFMVUWDtc5S
 GTqhzwydlp9OSnyCVSOouwfo77fGVEcj4mAd519yktRZkt8EgFVSi5gTt3phOR145/IGp679sew
 pogiujao=
X-Gm-Gg: ASbGncvOJawwA7Shhcqa+Gf0hTxmhtn9OLUdpjzTJCpiL6X+nVka/TAeF5EqbZZXhni
 WucTEtX5NqS8PKIXTF0P3fDwv13cmJh6eZl0wA29+H6oJAiNgnSeRVoYkn7tuudXEw4M+B0KZ/0
 r93LOUvHK5GWsYoadp1FKipRD7Sf1hRPymAJifDNo2CGuGvSuenomYErHqUZi2udQ7amnO2ZduS
 3dMK/CmW73d5dcom+g6KCpP6fSXQekoDLDzjYo3O3bIX4+66x8zgbhbE/QSDMew/pmtsxJqEhei
 k0ZA9d6hGgHqZePf9Xtr7aIP/SqahQ6s5vieeT0pi3bvLeQiIUAqIKNZeLFJwEWBMJG7pjRarW9
 Vi8cPwrlvrBKRjMPrNH+waULFghyoQzYLoQZQEz8=
X-Google-Smtp-Source: AGHT+IEdhf28InRJ1/qch3uHY0jZJ1BRgkkpujTOLfXAQH+9ihEjtwhK4/noIPdrWV16YQs6rpakGQ==
X-Received: by 2002:a05:622a:4d48:b0:494:adc6:239f with SMTP id
 d75a77b69052e-49f46154abfmr173246791cf.10.1748358430223; 
 Tue, 27 May 2025 08:07:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-494ae42bdd4sm171570271cf.47.2025.05.27.08.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 08:07:10 -0700 (PDT)
Date: Tue, 27 May 2025 08:07:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>, Ed Czeck
 <ed.czeck@atomicrules.com>, John Miller <john.miller@atomicrules.com>,
 "Igor Russkikh" <irusskikh@marvell.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Satha Rao <skoteshwar@marvell.com>, "Harman
 Kalra" <hkalra@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 "Sachin Saxena" <sachin.saxena@nxp.com>, John Daley <johndale@cisco.com>,
 "Hyong Youb Kim" <hyonkim@cisco.com>, Jie Hai <haijie1@huawei.com>, Ian
 Stokes <ian.stokes@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Long Li
 <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Chaoyong He
 <chaoyong.he@corigine.com>, Jiawen Wu <jiawenwu@trustnetic.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, Jerin Jacob
 <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>, "Jian Wang"
 <jianwang@trustnetic.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Jochen Behrens
 <jochen.behrens@broadcom.com>, Thomas Monjalon <thomas@monjalon.net>,
 "Ferruh Yigit" <ferruh.yigit@amd.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 1/2] ethdev: remove unnecessary type conversion
Message-ID: <20250527080701.712af797@hermes.local>
In-Reply-To: <20250512150732.65743-1-skori@marvell.com>
References: <20250429181132.2544771-1-skori@marvell.com>
 <20250512150732.65743-1-skori@marvell.com>
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

On Mon, 12 May 2025 20:37:19 +0530
<skori@marvell.com> wrote:

>  /**@{@name Rx hardware descriptor states
> diff --git a/lib/ethdev/rte_ethdev_core.h b/lib/ethdev/rte_ethdev_core.h
> index e55fb42996..4ffae4921a 100644
> --- a/lib/ethdev/rte_ethdev_core.h
> +++ b/lib/ethdev/rte_ethdev_core.h
> @@ -45,7 +45,7 @@ typedef uint16_t (*eth_tx_prep_t)(void *txq,
>  
>  
>  /** @internal Get number of used descriptors on a receive queue. */
> -typedef uint32_t (*eth_rx_queue_count_t)(void *rxq);
> +typedef int (*eth_rx_queue_count_t)(void *rxq);
>  
>  /** @internal Check the status of a Rx descriptor */
>  typedef int (*eth_rx_descriptor_status_t)(void *rxq, uint16_t offset);


This gets reported as ABI breakage. The change will have to wait until next LTS (25.11)


  [C] 'rte_eth_fp_ops rte_eth_fp_ops[32]' was changed at rte_ethdev.c:47:1:
    type of variable changed:
      array element type 'struct rte_eth_fp_ops' changed:
        type size hasn't changed
        1 data member change:
          type of 'eth_rx_queue_count_t rx_queue_count' changed:
            underlying type 'uint32_t (*)(void*)' changed:
              in pointed to type 'function type uint32_t (void*)':
                return type changed:
                  entity changed from 'typedef uint32_t' to 'int'
                  type size hasn't changed
      type size hasn't changed
