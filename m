Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23DDCDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 12:15:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89B6A40150;
	Mon, 22 Jun 2026 14:15:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A11A940144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 14:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782130524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJqxtirfeR6Uq4AVljYxnWnpZCq7udzyHF8z+RbnWh4=;
 b=MCAUfQNnuvVVc4XuH6KfS38xlqZ6S+rKweIJ0ityZqkDSUHLr78+xTM78jBII4b616nBYY
 UDK0kuSwEa2wqoGVseyfrrzpG+bBue04Bmjw4NsII0jcrw5Y2mMeZGh4TYeTxK8n3XZFZC
 oKA3lwOtemu84aEMXsSnvZX/yORM5Ek=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-m_fEB1qlOoiGk25aQ7MDQw-1; Mon, 22 Jun 2026 08:15:22 -0400
X-MC-Unique: m_fEB1qlOoiGk25aQ7MDQw-1
X-Mimecast-MFC-AGG-ID: m_fEB1qlOoiGk25aQ7MDQw_1782130521
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-39987ae63b5so18454311fa.3
 for <dev@dpdk.org>; Mon, 22 Jun 2026 05:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782130521; x=1782735321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJqxtirfeR6Uq4AVljYxnWnpZCq7udzyHF8z+RbnWh4=;
 b=Eihajwy/qw7cfIpxy8IhvSrMXwUZtQfcwxKR37Ji0QYC6AJ6+qc1PEZOPNjaTb3SN6
 F4fH7UcgQRHtKM1KtMUaqC+czAdxksW1bpmyFxvN6rRLcguBnpeatCO81oL98kA4L1Ov
 GaA5f2lM/s86WBQFdH9lGDJBiAH2zNa5x1QCf2ytFXdtmoGa6DskbTOHA3VGgBPknbU4
 FxP4+Jyw9COquLf2BXM8wJNNAZcQUUzHGZ6V9NT5LTbjHb2/3SK6NtnXUPsfGSyCPRPt
 StYJf20quZqBDgWcQD6CnmE8llfZg0cxWTpxishDt6llYZt++AVjecqo5GEDhbx2MWS3
 s6hA==
X-Gm-Message-State: AOJu0Yy1O5vxgDffqYYkwzBe1vaYObC97Bdl4kliX/q9GGK2l1RIlAdy
 lAlpyKNzIbyD2MBWwqhon6wS8XB78OBsVDUaDOFhgU99LUwTnBXN4w68bMyqI2MRU9zVoWs8UiI
 NusMMGShrgm3/epfO41ww7KR0Q8FIuW4BOY5a/xp7Le5tiEDQVFSxXZsT0bKJK4ijxI1U0hKynm
 YFUvNl9f8GhjsfAu5HEnc=
X-Gm-Gg: AfdE7cnzotkxEfXpb7UCw2svZVx8eXDDoy/5vcLuTf8kpgdUMLT1eTyW2mLO2GgOYCP
 MdLcyZPo1adzRjERm+P5GL59TZKcKdknU8OSxYMNBzLrNjr8ikK9v6cZ4FQNJ7fpw3UObjZ7gEf
 hmOHv6EVY2Vw7xJ92oCoV1XuPbiMidSl1lP4UOxVFP3d1FC+rqLxQ2Jwv+vmQPFrlaIz1925i/H
 cAsTkSE8DSJynB/tiB67SqfzflfzTQcKg1xh3yvHHJftVGhN8L+kZ7qHaA=
X-Received: by 2002:a2e:a5cb:0:b0:396:7079:5e3b with SMTP id
 38308e7fff4ca-3998bbfb36amr35184401fa.1.1782130520965; 
 Mon, 22 Jun 2026 05:15:20 -0700 (PDT)
X-Received: by 2002:a2e:a5cb:0:b0:396:7079:5e3b with SMTP id
 38308e7fff4ca-3998bbfb36amr35184251fa.1.1782130520401; Mon, 22 Jun 2026
 05:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260518181856.1228373-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-3-raghavendra.ningoji@amd.com>
In-Reply-To: <20260525184244.1758825-3-raghavendra.ningoji@amd.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 22 Jun 2026 14:15:08 +0200
X-Gm-Features: AVVi8Cc0_bBkcOtpj2YZ12WvFsEO7zJH3ej7yFG_YDRBA05PCurVLT1dywP1pr0
Message-ID: <CAJFAV8w6YVzh6QEThWAq50SccApMtAzC=okPV7Hph5EvD7cYgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dma/ae4dma: add control path operations
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Bhagyada Modali <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>,
 Selwin.Sebastian@amd.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t0m5CNr6oKlsV21XBa7aof_Iw5NuEBqz0hCtPRWilYY_1782130521
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 25 May 2026 at 20:43, Raghavendra Ningoji
<raghavendra.ningoji@amd.com> wrote:
>
> Implement the dmadev control path for the AMD AE4DMA PMD.
>
> This commit adds:
>  - dev_configure / vchan_setup: accept a single virtual channel per
>    dmadev and clamp the requested ring size to the hardware maximum
>    of 32 descriptors (rounded up to a power of two).
>  - dev_start / dev_stop / dev_close: program the per-queue control
>    register to enable/disable the hardware queue and release the
>    descriptor ring memzone on close.
>  - dev_info_get: advertise RTE_DMA_CAPA_MEM_TO_MEM and the fixed
>    ring depth.
>  - dev_dump: print the queue identifiers, ring layout and software
>    completion counters.
>  - stats_get / stats_reset: expose submitted / completed / errors
>    counters maintained by the driver.
>  - vchan_status: report IDLE / ACTIVE based on hardware read_idx vs
>    write_idx, and HALTED_ERROR when the queue is not enabled.
>
> The dmadev framework is wired through dev_ops in ae4dma_dmadev_create().
>
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> ---
>  drivers/dma/ae4dma/ae4dma_dmadev.c | 223 +++++++++++++++++++++++++++++
>  1 file changed, 223 insertions(+)
>
> diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
> index 76de2cde45..dfda723c13 100644
> --- a/drivers/dma/ae4dma/ae4dma_dmadev.c
> +++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
> @@ -53,6 +53,215 @@ ae4dma_queue_dma_zone_reserve(const char *queue_name,
>                         socket_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
>  }
>
> +/* Configure a device. */
> +static int
> +ae4dma_dev_configure(struct rte_dma_dev *dev __rte_unused,
> +               const struct rte_dma_conf *dev_conf,
> +               uint32_t conf_sz)
> +{
> +       if (sizeof(struct rte_dma_conf) != conf_sz)
> +               return -EINVAL;
> +
> +       if (dev_conf->nb_vchans != 1)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +/* Setup a virtual channel for AE4DMA, only 1 vchan is supported per dmadev. */
> +static int
> +ae4dma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
> +               const struct rte_dma_vchan_conf *qconf, uint32_t qconf_sz)
> +{
> +       struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +       struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +       uint16_t max_desc = qconf->nb_desc;
> +
> +       if (sizeof(struct rte_dma_vchan_conf) != qconf_sz)
> +               return -EINVAL;
> +
> +       if (max_desc < 2)
> +               return -EINVAL;
> +
> +       if (!rte_is_power_of_2(max_desc))
> +               max_desc = rte_align32pow2(max_desc);
> +
> +       if (max_desc > AE4DMA_DESCRIPTORS_PER_CMDQ) {
> +               AE4DMA_PMD_DEBUG("DMA dev %u nb_desc clamped to %u",
> +                               dev->data->dev_id, AE4DMA_DESCRIPTORS_PER_CMDQ);
> +               max_desc = AE4DMA_DESCRIPTORS_PER_CMDQ;
> +       }
> +
> +       cmd_q->qcfg = *qconf;
> +       cmd_q->qcfg.nb_desc = max_desc;
> +
> +       /* Ensure all counters are reset, if reconfiguring/restarting device. */
> +       memset(&cmd_q->stats, 0, sizeof(cmd_q->stats));
> +       return 0;
> +}
> +
> +/* Start a configured device. */
> +static int
> +ae4dma_dev_start(struct rte_dma_dev *dev)
> +{
> +       struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +       struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +       uint16_t nb = cmd_q->qcfg.nb_desc;
> +
> +       if (nb == 0)
> +               return -EBUSY;
> +
> +       /* Program ring depth expected by hardware. */
> +       AE4DMA_WRITE_REG(&cmd_q->hwq_regs->max_idx, nb);
> +       return 0;
> +}
> +
> +/* Stop a configured device. */
> +static int
> +ae4dma_dev_stop(struct rte_dma_dev *dev)
> +{
> +       struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +       struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +
> +       if (cmd_q->hwq_regs != NULL)
> +               AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
> +                               AE4DMA_CMD_QUEUE_DISABLE);
> +       return 0;
> +}
> +
> +/* Get device information of a device. */
> +static int
> +ae4dma_dev_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *info,
> +               uint32_t size)
> +{
> +       if (size < sizeof(*info))
> +               return -EINVAL;
> +       info->dev_name = dev->device->name;

The dmadev library sets this field in rte_dma_info_get().
Please remove.


> +       info->dev_capa = RTE_DMA_CAPA_MEM_TO_MEM;
> +       info->max_vchans = 1;
> +       info->min_desc = 2;
> +       info->max_desc = AE4DMA_DESCRIPTORS_PER_CMDQ;
> +       info->nb_vchans = 1;
> +       return 0;
> +}
> +
> +/* Close a configured device. */
> +static int
> +ae4dma_dev_close(struct rte_dma_dev *dev)
> +{
> +       struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +       struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +
> +       if (cmd_q->hwq_regs != NULL)
> +               AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
> +                               AE4DMA_CMD_QUEUE_DISABLE);
> +
> +       if (cmd_q->memz_name[0] != '\0') {
> +               const struct rte_memzone *mz = rte_memzone_lookup(cmd_q->memz_name);

Rather than resolve again, can't you store the reference to the
memzone in the priv pointer at probe time?


> +
> +               if (mz != NULL)
> +                       rte_memzone_free(mz);

No need to test for NULL.


> +       }
> +       cmd_q->qbase_desc = NULL;
> +       cmd_q->qbase_addr = NULL;
> +       cmd_q->qbase_phys_addr = 0;
> +       return 0;
> +}

[snip]


-- 
David Marchand

