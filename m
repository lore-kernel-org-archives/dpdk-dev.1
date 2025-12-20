Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574EBE668B4
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Dec 2025 18:25:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20FFA402B5;
	Sat, 20 Dec 2025 19:25:11 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 88CE840296
 for <dev@dpdk.org>; Sat, 20 Dec 2025 19:25:10 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so27866275e9.2
 for <dev@dpdk.org>; Sat, 20 Dec 2025 10:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766255110;
 x=1766859910; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CK+kBA01lbbHgWQK6knLqPegl9nWTyYKmuDp04WmxsA=;
 b=St7lMPXE9qA7XUSzwBYAUfGQOCbRogS2k8C+09UlkfU7ew/DssMFidoat4jZoWoGma
 aKOM8xF9PFTBFXNq2pSc93cytmi48A0KCe1LpOSCcaXT90ht0FeawSx/P5ofozbuNMQY
 179Gdh48N/hePqU+K3mFpWEyLHTt4cmTMZwYDuosie8nq2v0tG9b7woOTAGEfzw7m+Vq
 GfhPH7+37kzI25zhto3exDeId4wqdHMW+1nPG5hoouQm48+OaOxwcymwIMz9AbIRZzXI
 Rbwurjzj4Ks3l5vXZI4TV9BSdw1oTrRyIXdXcZvGXrU66uFRqDBG+7RFqE8cLPWVy1rh
 tE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766255110; x=1766859910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CK+kBA01lbbHgWQK6knLqPegl9nWTyYKmuDp04WmxsA=;
 b=qPTygiG13fNkP21N+E8pJkqvTLjQCYYReKfWcSLHMeYkKTiNlKlcHRLjyeSk+EV/ye
 4jFPegawJrCGeBod02fRBLoN/RbYiBbzT0bSy8IeOxKwk9g5pZ3b7YQQVL2D+Itieag8
 hzsQMNjs3DOPVP9yx4opNZ7ur5RdKQmukWeIbKGhwmNSCc+ZxsoFsCZSCfaujgMHOtfV
 IztrAthh/qxHNQGjeKgDG5efsMKM5Ioue4JNUIuH2RYJuhqocTCVGtwjQ7ZFIldKAlyu
 kZzmWwaKUwU5eEiFuLfC32F9SzmFHZBIvxMBmDNibCWy3xmusE0TCjU3N7cbplhsDTHN
 fFYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLVwF1/QxQcQamUBGLvanae5N0PtLZqWSdxEFTI80035hE8edzzseYhHM1ee4jJBH9T8M=@dpdk.org
X-Gm-Message-State: AOJu0YyiMVJAmeyOTqDNcPKd3NCm1Uj5GUkLLiociAg0PCyw9BgAs1a4
 COfjk+TMkkMSmo0IWvyNpXDlKnfNYgdqW7myTKuIlyvCNeWetP/H6Z5lLlJ5vRf1HOo=
X-Gm-Gg: AY/fxX5DPCTKnCU1AwVWy5cPzxpuUr9VFygnzRoEWFZQ7qqfxb6JdImHtF2Sas3ee4X
 ppWMPaGX/x75UC945gRfEKKTo9a65hcXJuVcX1Oz3Iy9VfedY572IW+ny8KgCk/M9b3+h46H7TP
 cddtA+Sl3xZi3pm1lNl84/Frh7Zpciw9TqnAirMwQ8Y3bqniaIDU/eUyAcjn1MHirwIjQemZsJl
 2Doyrw4fObSrPfUDcn4aZLiFcsDGh93X9pWmwm8G+WVEtznLxgFHIlRk8wC9L5k5WkgVGW7RWoX
 I+c4ZhQ4FZSwlx4ZjMich8Ck5ik/29ZNbR8UEmELytUKF9Q+duV69fdY9Br/I9Q7Vu1Dt+Vo8QF
 5qNU3wtRICx21IOW6jO/jilmLv7qTVYPogUW2eQH24fwBBrOCH2kkK/NvvK5eMQ2dN+dz65zwR5
 oUUx5v9apjfd43qK/GXyEL1s9TJixG5Z/C+9ZBygD0NUNRVwk7uVJe
X-Google-Smtp-Source: AGHT+IEMKR36eB7/ZAgA2Ar/F6h568NhxMXoQ6ctpb58rZBpLtczkZjiCYeUPH7T8mD781BBhjkogQ==
X-Received: by 2002:a05:6000:26cf:b0:42f:f627:3aa3 with SMTP id
 ffacd0b85a97d-4324e709b83mr7036014f8f.56.1766255109550; 
 Sat, 20 Dec 2025 10:25:09 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4325dbc522esm1230595f8f.11.2025.12.20.10.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Dec 2025 10:25:09 -0800 (PST)
Date: Sat, 20 Dec 2025 10:25:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: Madhuker Mythri <madhukar.mythri@gmail.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "madhuker.mythri@oracle.com" <madhuker.mythri@oracle.com>
Subject: Re: [EXTERNAL] [PATCH] net/netvsc: Fix on race condition of
 multiple commands
Message-ID: <20251220102503.54d04c5d@phoenix.local>
In-Reply-To: <DS3PR21MB5735BCEBB4C726C7E0B7AC4DCEA9A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20251212115238.59710-1-madhukar.mythri@gmail.com>
 <DS3PR21MB5735BCEBB4C726C7E0B7AC4DCEA9A@DS3PR21MB5735.namprd21.prod.outlook.com>
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

On Fri, 19 Dec 2025 17:35:33 +0000
Long Li <longli@microsoft.com> wrote:

> > When multiple processes issue command requests(like: device info get and
> > link-status) at same-time, then we could see the command request failures,
> > due to race-condition of common function execution.  
> 
> Hi Madhuker,
> 
> I'm not sure if we should use a lock in the driver for this. It's not clear in DPDK documents but in general the calls to query device status are not thread safe.
> 
> Is it possible that the application uses a lock to sync calling to this?
> 

I do not know of any restrictions about threads calling query operations.

For info_get() the transaction is in rndis_get_offload().
There are couple of ways to handle this better. One would to do
the query during probe and remember the result. The hypervisor is
not going to change supported offload. The other and simpler way
would be to just have hardcoded offload values. The code for query
got compute offloads is inherited for BSD and unless someone was trying
to run on Windows 2012 or earlier version of Hyper-V it would never change.

Link status is a little more complex. Does the hyper-visor ever report
that the software path is down? And reading through the hn_rdis_exec code
it looks like if multiple operations are in process the second one
should return -EBUSY. Application could retry in that case.
