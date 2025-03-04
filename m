Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C094C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 20:07:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DAFA402EB;
	Tue,  4 Mar 2025 21:07:44 +0100 (CET)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by mails.dpdk.org (Postfix) with ESMTP id 90FFE402DF
 for <dev@dpdk.org>; Tue,  4 Mar 2025 21:07:43 +0100 (CET)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-30761be8fcfso65845721fa.0
 for <dev@dpdk.org>; Tue, 04 Mar 2025 12:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741118863; x=1741723663; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=apYPwtZQbgHrG4JSh9M5brH3FGbbvA5LhJtijNU2zjPepcHXF660omteuJZeVjT9EE
 gH5JQP2MmpTuhY/bc5JcMY6K19vBXGJLr5GRLLBcWV+V//sI99g2S4rFie+EWafATwDo
 vU7sJfUOBofSV2zVPRI827vWF+kNr95SRSeXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741118863; x=1741723663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=wj6wuR8j7YpF8PNMaM+c+pejxRpijxYbs/xeaghJj+4nRIrTGOkyijomvWS+cODWET
 aAXXM46gfvF3i+rj31GRwkrPlph67ZP4RfCL5vxtqEYEh26RZ7oqjMNZ/lnTp8SNK0x0
 3AP6uT9w/Ti0GKmmMVm5zjbK3J1Z14nIYu6K8fa6Db3cyp0yvjMnMxmALB7h4DciMuJ1
 irtw6q8W6Y2/setbUNCb5PXA7W/cXqO5ZioyBrHBF4LgqKl3ui6FSWzDEwbv2T6JecgR
 B35aphltXCy4Y2rXX+tIMZ2VIyMoWAHwD5FMNXWKrsT4mX3s83smWBkImVMrttgGEsxR
 jJLg==
X-Gm-Message-State: AOJu0Yy/NLr5djH7jOw6FqwsRERvDmLEaXPUoCD2PbSRYQqjP3KzQvmJ
 glKBDj+ZJSeOoPnLU8amdy8pxBrPPCWci1eegeGvICLGw9wKVd73RB5cypHbE8atJ83iWQLRzI1
 mN7pO1tXZkdruoa3AIr1O9ljtw/8/Fx5rPAdFEg==
X-Gm-Gg: ASbGnct1P8+fPeGDUUlMXMSpd6Itt9YYRgDIaxBsg+mmSEdh69CxTfy/42OLsmkXJNf
 UfRbVkM02/QcrtKeofs7USYM2GTgjbdfrJezfCHca1CY2hf9wi42xib8f8KmktC3NV7iPTIrCQR
 uIs8tSFTN5A16ip/aHdEaPr5YwFJNmuXQXvN42YvAAEXWDxUo0nGirk8a7/BTq
X-Google-Smtp-Source: AGHT+IEo8bWstcBO0WoMwlYBHebvgPXeNlBRyhVDaQtfDvXGoqbcOgWBBsShDY13zlwW/Y3T7Smfpm7C/fIzmVcvpeA=
X-Received: by 2002:a2e:bc19:0:b0:30b:d697:8fac with SMTP id
 38308e7fff4ca-30bd7a0b9a0mr1542991fa.2.1741118862695; Tue, 04 Mar 2025
 12:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20241108134532.130681-1-luca.vizzarro@arm.com>
 <20250303145709.126126-1-Luca.Vizzarro@arm.com>
 <20250303145709.126126-4-Luca.Vizzarro@arm.com>
In-Reply-To: <20250303145709.126126-4-Luca.Vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 4 Mar 2025 15:07:30 -0500
X-Gm-Features: AQ5f1JpPFmRUJxjsoorITh3NT8YGr8F6yHntES_GjNfASshtsSjSkwFP3yYeYu8
Message-ID: <CABD7UXMRLNg4Xxp-scfTDQ0=o-jwjPMfGXO9d64HarQR_aco2A@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] dts: fix smoke tests docstring
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
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

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
