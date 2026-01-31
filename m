Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D415E7C6E0
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Jan 2026 19:59:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B8FA402AF;
	Sat, 31 Jan 2026 20:59:48 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 2DD0140274
 for <dev@dpdk.org>; Sat, 31 Jan 2026 20:59:46 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so34130955e9.2
 for <dev@dpdk.org>; Sat, 31 Jan 2026 11:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769889586;
 x=1770494386; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWssLKCyFrrgiRKrI7wH6s+todIWWjtYlWTLXs5rERc=;
 b=NfM1EtmILierYtHMIqgrWjJNSYdX0xDQpMnGTbhYWEGIkgWSH6Avxk9hgfTev2zG0+
 ztWEkebvJfcSNUi0Q520W8zT/vdP33dIxgByVJbFw6pfVjblV+7StExj/wBxsvAZ/NcE
 +5AGIq8WiAGVJHe964YTqpDdhcKKBz9corB2QUII+hknY3YwalK0X5kP+Oh2nSFDnoVA
 5IRU4GNDGQ9GkeMGHXbm/Su+ElRcBGssHIojLQeGCXaX5sxyHEngaIA0ENli/0KDHJ4e
 7wzUnFFcYdold9s4E0nb8y60xodryudimgvYl4vPUy1LbHnU3VBx2aPmcMNcLmig8iFG
 JXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769889586; x=1770494386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EWssLKCyFrrgiRKrI7wH6s+todIWWjtYlWTLXs5rERc=;
 b=JjT1HG0sVJGZ1l6JMqCsjJhGZFT5gHZL3+X84+fBaq8WqS97Acy00OW/UAPvDA/R3J
 Zov0/hj8UUTrHOMcDs8G38swJMjFKfjD4qBvBGMQoAz4e00xMXG7WkTjC+fdVWoC3RNu
 GSRozjpTdGwDbPHkdtZSxe0mIpwGR8ag5YrSdnzwjiL4D+46tVT/xDIpqXzstyrLCtXw
 Avum3FPGMkvKzNyrOiIJZaZSfOtpHsK7PLnaVIJGcEpwU6az6rXljGJ/YLpfacAIJefE
 pZxfI9hB0e5JehFYhuUDT8mraZMMeDmt3UY+TxD6O4/gaYe8vIOAwOvDeVVOo0gxHHTl
 u2WQ==
X-Gm-Message-State: AOJu0Yxfi1wyfUc0nYqX/GThgYGZbLRz+bUt/pRMrIwMJ4InnYDmIM3b
 6KqNU7IAupPZ/FSd/XZgSLHDebSU27i49VbFNdp2R9m3cDQY4d1kfGp+JhpLzHaw6yE=
X-Gm-Gg: AZuq6aKsF1nP2nMVB2PvrmrGyi5XtfRSWEWNyYdE3Em3LEpdRw4sN/0I22yAnPNIU1t
 XOSjj2LLC8WR7ORdbcEvB4faX7mP2df3FtE5QrXcv78d8UBFYC2eo83rnBbrGztK91VO1wJXHmI
 p9gTNf4q43KnZ0UsVvIic0M17YWnRiPDE4cDHtHNRjMPne/IoB4Qlcq2YnrtyduqzOURjUynZlc
 y0Qtxn0yfROVvd1RrZB8iONMfHFSFRC6++BUvB104ePwH/1CALnBTMmjlI//oBtyQElvNobyRbI
 dTBi2J9E8emp+kmd01/TmYPqKEcQxwXj/25Y8cG20DPlhg/pfXIqTKr6I01FK3ZETmz6hyGfk27
 V2mnVDdBaCfo0CzZU4CLrRskw5rcr4ZO7sR39I6mdNAR68KxL/B3w47NC4EGhU94CfMyChKdTJE
 bJUh6i1P32NdCYZMqImHzUWfdYwN3GQWvSsWX6cSMwn/ek8L1GxdCEyO0E2N7sJfM=
X-Received: by 2002:a05:600c:1f16:b0:47e:e712:aa88 with SMTP id
 5b1f17b1804b1-482db4a0bb2mr106280375e9.31.1769889585643; 
 Sat, 31 Jan 2026 11:59:45 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce58sm31034561f8f.20.2026.01.31.11.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 11:59:45 -0800 (PST)
Date: Sat, 31 Jan 2026 11:59:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] devtools: download scripts from linux if not found
Message-ID: <20260131115939.68b49e16@phoenix.local>
In-Reply-To: <20240315141441.259594-2-rjarry@redhat.com>
References: <20240315141441.259594-2-rjarry@redhat.com>
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

On Fri, 15 Mar 2024 15:14:42 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> Both checkpatches.sh and get-maintainer.sh require scripts that come
> from the linux sources. And they require DPDK_*_PATH variables to be set
> to point at these scripts locally. For new contributors this can be
> tedious since they will have to clone the whole linux sources just to
> have simple perl scripts.
> 
> Update checkpatches.sh and get-maintainer.sh to have them download the
> upstream scripts if they are not found locally. Store the downloaded
> scripts in the .git/ folder so that they are found for future runs.
> 
> If either DPDK_CHECKPATCH_PATH or DPDK_GETMAINTAINER_PATH are set, they
> will be used in priority.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---

There are two many open questions on this patch.
That is why it never got merged.

As long as we document existing usage well enough it seems ok as is.
Trying to be "helpful" by doing curl opens up more issues.

Lets just keep it as is. Longer term having better local solutions
would be good. Ideally checkpatch can be replaced by AI and
get maintainer could be python script in DPDK.
