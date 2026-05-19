Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C36ACD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 17:41:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E5BC402EB;
	Tue, 19 May 2026 19:41:48 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 19C88402E9
 for <dev@dpdk.org>; Tue, 19 May 2026 19:41:46 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-303dbfbec77so3534240eec.0
 for <dev@dpdk.org>; Tue, 19 May 2026 10:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779212506;
 x=1779817306; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3rtlah1+gUzPjQXy/bWqQFq5lXU20Mg5qZcwOM6jmg=;
 b=oDnaJ5AxvajueKDmXHMi1h/Tpsyrp9GJbzsI13bx/+G2yfJbzfJAEJ02Kn0csIhv1g
 VeCOQIEG3z1iKFeHQQPjEOKpttPHTSZxkW3pNkWaKhtLnaYqFWzMK9gOVxQLvjl168A/
 CllfN3opSPzZTTWtnPwVyDlMHT7x1a2Mszu7ctINyDA4784PTo3dXDZHxSJmfSyW82Ov
 cBRydGvdQ/YxRIu1tMWutu8vo9QkWelTu0iplVj/abYDHhfhr4ljJbNq+XuBhe+aGvOg
 hX2G95FKrL9ONfMDD5Kjf036s4AdJ1bv/SvCbFXj27j9mu5mwiOe+sIzim46ke/qFAne
 7f6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779212506; x=1779817306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f3rtlah1+gUzPjQXy/bWqQFq5lXU20Mg5qZcwOM6jmg=;
 b=E99RoMwEkAcc6HCJxt+ANdI9BS8hzzegvanXMdOey6Sf8V0iY/4CMaFKqxUpbsbM3s
 uqriYykQ4zaPzFf+hf3oBuFyJbc515fmYO0F76ICOR7RUH/bKLR5u6fO+ulqkLf03s07
 qEtOteGxyap57Ts9kmv1vVAEPEYXKYboaSXhxEPKCqzBGGSsPPHMIcohr5rmjilp//IS
 N+XF0fqidtCH3KINegr5QScFiQV/Z1xYxjBKOK6c6c7D5ZzZJPjKUzyvtkwUzzX7+ZRr
 QU7PlCvgia3IGMqsR+jsF1FGgEJZEqXVAoLY+teCEFFlyMbY6XZqEzDj/KBXUWjQIVag
 7VDw==
X-Gm-Message-State: AOJu0YypmoVo9BzxtoGmwRMEUiwLmHuVPOfpX8gI9kXFUWWf+AnalNvJ
 BxboIpH1l0U51G5Dh8KZGgKLRBjJ+YU+/A7tWrwpi5DIiulhLRNmo6NpU3OzalrZ6McHPIc5+3C
 gwJVWZWk=
X-Gm-Gg: Acq92OFXZO/YhcjeVrYZSo/u2oIhi32Xg89RrXuOYVIfceotwvuS7T69nMPcAfc6acx
 yaN3K5hBvgirNmPhmfYKrleRuw7IwzC85GNhRAhejS1569dJub6LrDSpuiocXDk9vVSqfOHdD2G
 ZsZdIsPNIAMVhWQRInnk3ekjeP8GAOdCq+byjpX8uaQLVQGhBuZY+YNW2LGn8jJ02Lc7SkBOksX
 y/oBR6fm0Az/iJlQTPua7tNw3MrU/9Ha7nvObbbxdzbrPrQHoE4pr9WazxA5iTnlVMNT/8E6nVB
 ozs12EMBjbVWqV0RWYArdSOyo0ToCpjHcRSZkyZ0r1350wPW3Lvh4hN/T/rjTieWNrbdmfzTEbq
 GdwcxtSMoh8oNd06XjpOQXdPUqQ16rSzQtosth01OJWh9UwQI+h28iX/ysxUHyOoLFETp248YnK
 VEwLf2DIx5LfHypxAI+1qrU9VQzY1t5vSkagK5GSUHi13U7ioeTgKiH1V5
X-Received: by 2002:a05:693c:2c93:b0:2df:71f0:e5b3 with SMTP id
 5a478bee46e88-30398618b71mr9605206eec.20.1779212505785; 
 Tue, 19 May 2026 10:41:45 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2ea6dsm17039026eec.4.2026.05.19.10.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 10:41:45 -0700 (PDT)
Date: Tue, 19 May 2026 10:41:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v17 07/11] common/sxe2: add ioctl interface for DMA map
 and unmap
Message-ID: <20260519104142.5ae57e90@phoenix.local>
In-Reply-To: <20260519030132.3780057-8-liujie5@linkdatatechnology.com>
References: <20260518091405.3295896-12-liujie5@linkdatatechnology.com>
 <20260519030132.3780057-1-liujie5@linkdatatechnology.com>
 <20260519030132.3780057-8-liujie5@linkdatatechnology.com>
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

On Tue, 19 May 2026 11:01:28 +0800
liujie5@linkdatatechnology.com wrote:

> +RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_dma_unmap)
> +int32_t
> +sxe2_drv_dev_dma_unmap(struct sxe2_common_device *cdev, uint64_t iova)
> +{
> +	int32_t ret = 0;
> +	int32_t cmd_fd = 0;
> +	struct sxe2_ioctl_iommu_dma_unmap cmd_params;
> +
> +	if (cdev->config.kernel_reset) {
> +		ret = -EPERM;
> +		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
> +		goto l_end;
> +	}
> +
> +	if (!cdev->config.support_iommu)
> +		goto l_end;
> +
> +	cmd_fd = SXE2_CDEV_TO_CMD_FD(cdev);
> +	if (cmd_fd < 0) {
> +		ret = -EBADF;
> +		PMD_LOG_ERR(COM, "Failed to exec cmd, fd=%d", cmd_fd);
> +		goto l_end;
> +	}
> +
> +	PMD_LOG_DEBUG(COM, "fd %d dma unmap iova=0x%"PRIX64"",
> +		cmd_fd, iova);
> +
> +	memset(&cmd_params, 0, sizeof(struct sxe2_ioctl_iommu_dma_unmap));
> +	cmd_params.iova = iova;
> +
> +	(void)pthread_mutex_lock(&cdev->config.lock);
> +	ret = ioctl(cmd_fd, SXE2_COM_CMD_DMA_UNMAP, &cmd_params);
> +	if (ret < 0) {
> +		PMD_LOG_INFO(COM, "Failed to dma unmap, fd=%d, ret=%d, err:%s",
> +				cmd_fd, ret, strerror(errno));
> +		ret = -EIO;
> +		(void)pthread_mutex_unlock(&cdev->config.lock);
> +		goto l_end;
> +	}
> +	(void)pthread_mutex_unlock(&cdev->config.lock);
> +
> +l_end:
> +	return ret;
> +}
> +

You shouldn't need the cast void cast around pthread_mutex_lock/unlock;
other drivers don't do that.

Also, git complains about this when doing merge.
Applying: common/sxe2: add ioctl interface for DMA map and unmap
/home/shemminger/DPDK/main/.git/worktrees/sxe2/rebase-apply/patch:192: new blank line at EOF.
+

