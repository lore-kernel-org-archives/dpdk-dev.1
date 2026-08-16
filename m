Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4428BC5DF66
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 03:29:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 942CF4021F;
	Sun, 16 Aug 2026 05:29:55 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 94FF640144
 for <dev@dpdk.org>; Sun, 16 Aug 2026 05:29:54 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso1584854a12.1
 for <dev@dpdk.org>; Sat, 15 Aug 2026 20:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786850994;
 x=1787455794; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o9j5sef8ufoSys0A6srwSMMmmIatk4mXq6o780XAL40=;
 b=m9yijvJnrr7MNCBGdoW44CPxL5K17yKFzcYpNxhsMQO79RwGIEcHz6s24Rh8RsHsrf
 +P6OKMT7lgETBI0tx1JQ4ntdKCKVdfzREskuuwRExQ9Okkzjyl3E1jlQ8/2djnjjohgK
 3UwXoqE7qxJ2fCGR6cZ1ChMMyx353iEAkj/hcJnz5A5GnNAB2ZCuHtG4EwcjDsgshtoq
 iH948w4F7ArXsJIOG5FoCnHqXc6HjD/tnWbNcQHtrXWcaXJnwSqD1JjjsxdkEKF24HcR
 nm7zXPCT+qwGAtMdR95T8U9Oo4aSIe+YnMlerIvVYq+yXR79kn+QzEZJ+q9wnb3SSZgr
 LU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786850994; x=1787455794;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o9j5sef8ufoSys0A6srwSMMmmIatk4mXq6o780XAL40=;
 b=UrIFWQ0DMW87OkjKYSVBu6qEDjlh+LOexoipWuwpC4YSzkAPhyuQzPg7jpI32ysMqS
 mlccE9H/ntm6kFepTP2jW2cM2RDjVAMgSWYJJPR0geB+VuceKNlaohCE/uWBUCp6l4k1
 9hprlBwrUszNaRE9Jbm8RixfDq6kd239FpfBhpEtgTcCRI6NKSI0ozFwejQIJw8XaSLD
 HEFGZ3uTskT2UGy30/fdulYNnP97vRZcoSkaAHMcqh5wkltCPlIaQaNxbd/F3O30GpF+
 iKB8zA6f1PoMzcteMDSDegb2uXd8fzd+yz297ackLsMWGIedzR2ZkHmRIf3p3uNp6sih
 3BWw==
X-Gm-Message-State: AOJu0YyfWdWzhnG7lp5W1Y1f1TOw4mQCWA8AhPoJJGZcdflq5D/fy4jB
 tyQSAS+6AlTRwT1ksjaQ/Qkrv0MUkh6HtgnWMuJSSaowKPOTq2bpVxywKU8+wLkfkAo=
X-Gm-Gg: AR+sD13j+i2cmpjSWFNhzIvlzoycNEOdpMiQI5NkNJBjDkLJaV1MPW8DngyIN5crIaK
 FHU/obQuOI7tmSAtJEdapj53+gFmQD8HdLNaR2nPA1e/Mea8MuPPye1k6a2q9e0b3U1sUfpNuCH
 +1CHSuk/DJ3u8hAv75h3Lc0dIARrqQaSWk/DovAb3wEC3HGlef8ln5ZjW0dLFuWds9UQeSgFKc7
 +XCC/uKbC9a71BCGhi0ORMHTHcfSUAD9EUW079nLj8NF/dHGXlL4aG5iuLun98wSNYZsoQQxUcy
 jRsTurxOKOYdQWiIJA1IVgbmGVPm7DwYufiCx7L9NGiEcPYtSPYpgCMgtLwFTDDeJWylExPqqcV
 O9l5GPUxvWfNgb1bHvCqzdHdGlm2G6iuO94a9/41zcMdnVBvorUzAHHD94lyeIkbiFRpKMxa5gW
 f+0BHB4/pA/ajDLsEHeBM8vSOOgAHcxTaNK44VxzlBdY1Mv4chzLSY7Ceknfe3xvvI6fo2Pj14B
 /n81A0plpvPnjns7L2KjEAsvkOwYA==
X-Received: by 2002:a05:6a20:914b:b0:3cb:eca6:ce5 with SMTP id
 adf61e73a8af0-3cc71d1e8admr17478781637.24.1786850993620; 
 Sat, 15 Aug 2026 20:29:53 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ea8fe3cdsm21318779eec.28.2026.08.15.20.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 20:29:53 -0700 (PDT)
Date: Sat, 15 Aug 2026 20:29:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andy Moreton <andy.moreton@amd.com>, Viacheslav
 Galaktionov <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 0/3] net/sfc: miscellaneous bug fixes
Message-ID: <20260815202944.6ec230f4@phoenix.local>
In-Reply-To: <20260812171017.8521-1-ivan.malov@arknetworks.am>
References: <20260811174913.8961-1-ivan.malov@arknetworks.am>
 <20260812171017.8521-1-ivan.malov@arknetworks.am>
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

On Wed, 12 Aug 2026 21:10:14 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> Three independent fixes. The first ensures that Rx queue
> type flags are derived from scratch on every queue setup,
> preventing flags from a prior configuration persisting
> when an offload is disabled.
> 
> The second patch removes an erroneous static qualifier
> from a flow RSS iterator variable, which incorrectly
> shared state between multiple interfaces.
> 
> The third patch corrects reading of the advertised
> autoneg capability. When the user disables it, the
> corresponding bit was re-added upon the next
> link-state query.
> 

These are applied to next-net
