Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F07C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 16:59:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 810DC40265;
	Tue, 15 Sep 2026 18:59:16 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id CC3CD4003C
 for <dev@dpdk.org>; Tue, 15 Sep 2026 18:59:14 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccdaea76so1406011a91.0
 for <dev@dpdk.org>; Tue, 15 Sep 2026 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789491554;
 x=1790096354; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OIXe54dLzek0Xdz09jQwsaavmnQIF/olk7qLlmhcJg8=;
 b=vdvbspz4IAulwjgCutV4w5UVnqcmque1lQc+q6xbZ/iPg7w3hIYuOZIQpmKVdRikSA
 e4g2j3pggBiYIgsvauxuGCSehmIWPm/l0It8vPRv5CjwhvPlQ9mQhjacPUsmxOIxybEU
 MgtMNMY6HjRV8iUdRblQc3GhhRKGERpamzkTRmL9jt9I/OyV2z6A3uIHq+eNUk/nHHcw
 voQBBTAkyHN+NNRG8s8XQTkKTxKmXCkRlM612U7GGK9qKqcwH9EeVSNbOuN8LrpQhH6O
 nvNBnIZyOMlGt0rJjDY0/mhFhnCRgE9zT4onAyduqEod8PY9u+uGyxrAhZkmSeue5BFj
 mg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789491554; x=1790096354;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OIXe54dLzek0Xdz09jQwsaavmnQIF/olk7qLlmhcJg8=;
 b=KIlR2Ga0yULcUGoMP2Q0Q/l6pr2Ssndq8QDif9ICCQ4qFRaZplM4rvq8xRDMOQdiop
 KSxrWUylSXwHerBbJgfnJF686oPiYkEQIkGhZnjIsHCEJjXbvnvRSKjU97lsHAachsXj
 czCfl2RMf0+C+XeAbePmEV6O7ndtPkYw+5a0/W/ZIfMrjFl+NjIMEh0rGzEEKFl17PLt
 qs1432PbCEdo4wZkdOMYr1/A+Td9i8gwek0BCxHYZITvyyJ8whZXuX0TWQyYl1w2vTY9
 bTFt9bDx/nWyGWf9TNAKZtaJTxuqSvY5h8McmGpiDhi9ge+iw5mpj4gLptLYmjsLiUpr
 KGdA==
X-Gm-Message-State: AFuF++kKoFCP2D+FS7a5LibvsLHjoVU/xY6Z8UFVhAdMMC8VFI/6AKpy
 svAtXPnpxF7dxIA3gNzAp05OXPXPNEzPLCIxGgBaZxhPYxk8JabeV5tajjn+oZI1Y/RFfdNiAD7
 9Igza
X-Gm-Gg: AYBFou28QMLZWadIdIxc4MlC/CUZQMwrpuLpNbR5AsiNygrSD82CWzKrheFWlaNMKCF
 oYdeq4VymPyeRJZVMdpOE3REEuPttk//E6AxkYxLTX6ezPyIZL2ZXWC9JVtpZ4cW+EsH0gWQ/CG
 /kLAkkb9dUPHh4w8A6Z/+IDJal9frrWHDcuiUGJHvsaFmzwAgv3fd4z1GZLL4/SHqemRVgCGmo6
 w4tCxhycM+GaEU5tvOW7A+EKWWdBCXa44D4QJMN/gpwt5lw20+u81+e+x1PUM0mOdLqebYHhSBR
 akm+cvtSYE+NiK/zvQ+9fS8Y6g82g7ViNHlxUUPUh4mHhNtvl7eIiccVfs1mrFh+tz6L567Fbph
 1HjDZsWF0hiytleFZ0shuXTRP93OBS4o2cCAOf5OxijUT1AisDLLaORMABjCN8aNcJ58m6LCcpH
 bsYt3xy2cN9g01KbggsB8Ui2I31XZVtpSUj12cDFLcBKD293vUn6wioA9n1k0oPvLVD1alC4TF2
 MhXhV4Vd2Mi70XshEC7XvceYzSxx4XJtSld49XWyg==
X-Received: by 2002:a17:90b:4c4a:b0:398:ba46:1d9f with SMTP id
 98e67ed59e1d1-39dfe14719cmr4989451a91.13.1789491543344; 
 Tue, 15 Sep 2026 09:59:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e19cfb136sm155564a91.0.2026.09.15.09.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:59:03 -0700 (PDT)
Date: Tue, 15 Sep 2026 09:58:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] examples: add Wycheproof validation app
Message-ID: <20260915095856.2e597fc4@phoenix.local>
In-Reply-To: <20260915155157.2446094-1-kai.ji@intel.com>
References: <20260915155157.2446094-1-kai.ji@intel.com>
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

On Tue, 15 Sep 2026 15:51:57 +0000
Kai Ji <kai.ji@intel.com> wrote:

> +.PHONY: clean
> +clean:
> +	rm -f build/$(APP) build/$(APP)-static build/$(APP)-shared
> +	test -d build && rmdir -p build || true
> \ No newline at end of file


Fix you editor config all DPDK files have newline at EOF

