Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF43DCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 15:02:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4884D40651;
	Wed, 12 Nov 2025 16:02:44 +0100 (CET)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id DB9B8402B0
 for <dev@dpdk.org>; Wed, 12 Nov 2025 16:02:42 +0100 (CET)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7ad1cd0db3bso806862b3a.1
 for <dev@dpdk.org>; Wed, 12 Nov 2025 07:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762959762;
 x=1763564562; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKLTWgjFABfDAm8HxtZj6blyBJIqqQj8jq85GPFx0mw=;
 b=IsR2vPEp82yD08KyCzOlwWXi4dlwNbXL+oHTj+tPbBJfpvvxUgI+Uu5iplP+uEWJH4
 E9fFI1mMu840+Zu+bJlDGcWoazXq0CZlpDoVb6JlHZ/gFxM7Qn3symD9DgPvtE7SJpEp
 IUUh1Yn6BItkD6vQGtpjkcgd1kn2A5/eNsBRMq20VoUvX/s/ponc4R0RaESUQ6JFyGEA
 VVyR6OdkmqZrf/tSdo/uiZ2jbrdhZpTRLRuSLHDQcQTn7HhV6+xKlzmZ00IMQ/MmBXDT
 NGTX4JZITTt3A1w84Z8tyTG26l+6fOl9mQsgtQoldlrLUeZaZgdr6fgu5VFffz5yJIHg
 uq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762959762; x=1763564562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wKLTWgjFABfDAm8HxtZj6blyBJIqqQj8jq85GPFx0mw=;
 b=iDaQ8z6mdQ6YYhrtJiIN1UdKdsGwhDdN1nBDG+DQbZY3/01KHz2vb1r1QPjTEpJTq1
 iOnR2NYNkD3mexxLhcKRzq1DJY2deVcgJjL1i9mwPGGOzGauRBQ8Nw5CiX5DekH06BiX
 P9wF/0GAxMd1ZMQJd8PxEu4eJ1a62hljabIz5a3TaqrSxe0Nqcfna2+8hDMq+5B+3Rex
 BS3/vmQBcCEUKjrcPYJO+lLdkhnuiHjOMcYJlv13uYeYRFS26aSUim/kO4eQMxFPbqGA
 NIJqoIYiT3+1aRnPQcM4kl8tjaaMrljTUtlodYkBjq6D2a6fQ94jq+QqZZ4m9/T1bIZR
 O4hg==
X-Gm-Message-State: AOJu0YyYON/ZrZtyvwS/g3wjlddRe5ApY2SCMHIIqtuzdtsoj/lpk5+D
 n0n7ofgusQ4pVPa2UqioXrZYJ7gchp0dSFECppJSgs1Zpc6Gm59hLz+CvXO2qEVSElo=
X-Gm-Gg: ASbGnctKuwXYEZ/5GZgaEpd2YC7Mhw3ZKd5+Y1QjfvsfP33yzQzWUW/7dD6pM9Fko+N
 u0QdutFa87BOnmuyUZjqYR3o8uPWQlSsa2QrHAY/74lLx6k6ZbVMpkSn8aQOwPVkms1LL4yAMY3
 mpQExf60IqGXC0Z1ZO588OeqLy2dcoIZ7PjYXqDDdf+aT3aqIB2dQf+/xOAzxARQQUKjvMDyeha
 7mOlSSl9M8X0Zf8DT8V2gorY9hRK8SFSid42g3pt0Xu99SxEP1AziUhRBjT+p+vd+YK9dXeUgF8
 mVl05P6Z97rF/3pNnhzkrV0jZPCHvGSekm3Pq4j9bET67xqeOp78PXAGajmbqMsXzFssarN9ZtZ
 TP5O5Oi/n9Vco0Ss3pu6cTU3VnV55mkCdmk30X3wP52yd3IeimjVFN8KFJviCjjxi8qmbuvJov/
 /31TMHoIGpkIhhuSZ8Se0CJkra10+EbU9GUA==
X-Google-Smtp-Source: AGHT+IH+y7aF4PeHz89idYvmEcVKdjJrblOSiolMWuhHOAVQLYGykyp6hg+GfNDVEPhPbGCuVyApRQ==
X-Received: by 2002:a05:6a21:6da0:b0:355:1add:c28a with SMTP id
 adf61e73a8af0-35909095ff3mr4371897637.2.1762959761620; 
 Wed, 12 Nov 2025 07:02:41 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bbf1868ad0asm3033413a12.31.2025.11.12.07.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 07:02:41 -0800 (PST)
Date: Wed, 12 Nov 2025 07:02:37 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v4 1/2] ethdev: make representor parameter more explicit
Message-ID: <20251112070237.6799779e@phoenix>
In-Reply-To: <20251106055246.360824-1-getelson@nvidia.com>
References: <20251028095831.53669-1-getelson@nvidia.com>
 <20251106055246.360824-1-getelson@nvidia.com>
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

On Thu, 6 Nov 2025 07:52:44 +0200
Gregory Etelson <getelson@nvidia.com> wrote:

> The current format for a port representor parameter is
> '-a DBDF,representor=pfXvfY'.
> That parameter syntax describes port representor relative to
> PCI device DBDF.
> In that notation VF Y belongs to PF X and PF X is relative to DBDF.
> 
> The syntax 'pfXvfY' will probe 2 port representors: PF X and VF Y.
> If we want to refer only to VF Y related to PF X, the parameter must
> be '(pfX)vfY'.
> In this case only VF Y representor will be probed.
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> ---
> v2: Add comments.
>     In rte_eth_devargs structure rename port_flags -> flags.
> v4: Rename devargs flag macro.	

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
