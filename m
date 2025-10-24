Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59661CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:11:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F33740652;
	Fri, 24 Oct 2025 19:11:28 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id A3B4240613
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:26 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7a28226dd13so1361671b3a.3
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761325886;
 x=1761930686; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WKmpbCH3jMpLsUD90V1HMDpCAtfxZCMeWYfbzFRYr5Y=;
 b=WyLDw8Opo5iVfQfxMkWsiJGEt9zqkyKkKpZChl8YsQuEFvXTTnS1JDTNmNHCf46RsU
 4jBcPPxbBn0ZInnYnAbw+Wf+vNkJHPrrq5MlZSfQSzwGl7kKlvUyE+crDw3vz4F1ILtj
 FYbio/3d03vRAgMVBfK7CsI+/oNo1TZum3iY6O9zo7Z8Jsb8Be8zGG/2VqWLD0F5MBT5
 rF1pTiJHmOiseNeVBcMaF+VYNura0gwMZAzxezxwU6XYWuQcy5k28SqMBf8zW2pEe+Me
 8LyJzyHeSvqL93FwHmHOdmzeIgA4+XXsROJgoAiD6JWVHvKO0/uy3UDXrFWuRKJ6ntTg
 J+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761325886; x=1761930686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WKmpbCH3jMpLsUD90V1HMDpCAtfxZCMeWYfbzFRYr5Y=;
 b=ctb0icG8yeRqjbzLEA8asIcDQX+k+hiVrKiSRq+hevY1jRn31a7zj59QzmYFMlxGPM
 PLIA2AoqNJ+wbpgNDVsZREBwPE8WwefuqsbWF/dYMEOZbELYt1qEw0WhDMgQpiy1RbIF
 BiBWzNXVQJM3a89fPutPxvL3P5azug2fOIURdg35HWVcHdyhEUgevpPpiH9QjKmkUkq4
 9FHTV1W4/IPmUj9hZqeqU8yDVzG0OtbfzoBOE8ryw+1uCnyqoE/x4oGwC7rwhlpLYCHg
 bGryIb5xB43F3KNWZj4wbtzmZio5quaOoCQNCbrUSC9qZC9TF5RUBRPN8/7Gq7jCVEtj
 yG3A==
X-Gm-Message-State: AOJu0YwxyCwA5t2NlXX63swdSK9UkQMiOKd6OIEtTo+SD3hmLEQy3Fvr
 kxuOw7dXSkwsukVIS8mQYVVMUlYBH2sxCdoEm9RpYNwP9nGVN/HewbI9RojtGB9WFRI=
X-Gm-Gg: ASbGncubu55VOtRotDDX1MV+W1h56JKcYm/ySnAjym18WWzNLSrzJ/KrIdyXk0Naeec
 jREsfusM131Sk15BKvJrTiSvlIK7F+PXgrv+fUOdGD7sCV40KviHV4ALfIApb4qsoVdIVE7xPbs
 lRlnwV0zWWJK6ipcMsEa/lrtyGpS87R5ClhD+1nC7rVKPdfQ8Xd8QwIuw7p+qVhraNHj6Xyb3AM
 jhzGHMO4TGZCw/syXWBpzspT77SEd3DqZXqa/ldrauoOWzzf+Fxc50ZmGnSdyRd3FMp5y4Ni238
 3oGq7UbCccOrNsHncns/jpTp8/hBixf0omGURlM8ESgHHEMqk8oEhzo2JHHAixvE7YMyPkX+nmc
 Q6PDpQUX2CIGbpSoE7WbeGgwmCH8Y0yfusuKSYCp8PA+lSFd2lv498z3LW1cOXlw00LT1nEA26f
 cAtYHriSmbatiacWnD9XXzVdeZs9BxrbizeCnj+Lpityap
X-Google-Smtp-Source: AGHT+IEP6aG9hOwmkSu19M/1AI7qWs6DOMBqTfZG/ZvwswUW9J9KbhfxfQBbtiZt0o1G/Ihp3vpBJg==
X-Received: by 2002:a05:6a20:430e:b0:32d:a70e:120a with SMTP id
 adf61e73a8af0-334a8621362mr42333035637.45.1761325885846; 
 Fri, 24 Oct 2025 10:11:25 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a27d583970sm4669776b3a.51.2025.10.24.10.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:11:25 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:46:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 03/13] net/sxe: add tx rx setup and data path
Message-ID: <20251024094636.49a4fdf7@phoenix>
In-Reply-To: <20250728090517.1811244-3-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-3-liujie5@linkdatatechnology.com>
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

On Mon, 28 Jul 2025 17:05:07 +0800
liujie5@linkdatatechnology.com wrote:

> +s32 __rte_cold __sxe_rx_queue_mbufs_alloc(struct sxe_rx_queue *rxq)
> +{

Stop adding __rte_cold to all functions.
It should be reserved for special cases.
