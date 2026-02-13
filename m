Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E78EF99C5
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 18:47:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70616402C0;
	Fri, 13 Feb 2026 19:47:56 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 314E2402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 19:47:55 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-481188b7760so11089765e9.0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771008475;
 x=1771613275; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efBfyxx800HpVK9PtBscu7hbKPhGN0wWHMduwT0cMhY=;
 b=W/a0dgZvmGVC50x4qxi9tbGdXewj0NMHcOt0et4gWyf7DKEGBoExnElRrdQyH1ZJG7
 k3KexxCegwsD/+BG30VfVsmnt/zsOZ9DlXspPhIytW24MOzFTY6l3mBAQOM+vd2mlnrZ
 psBEXdsLca0pB65nt2B2eE9Mlb0uFWrJ7zqI5ZJrbMP8Mhr192RQKlCtRB/AeWHUrHGJ
 aNpTaWw5GDzz9NtCVZ8P5TOn4aBaG8JnRqnqQUdIb0fV7bPzT0Vwe1vKeHgPq812UGjI
 ghZHGDk9N5YkixDx4kQiAmUbxIkC3nDTJ0f/xHD7a5i6yuy0dgBpzyTXubRoblN1ECvJ
 GdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771008475; x=1771613275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=efBfyxx800HpVK9PtBscu7hbKPhGN0wWHMduwT0cMhY=;
 b=AdNoiW+ufiED/DmpE5qFo+qxd708sLiYxwj7dlR1AcpTBDWZgeYtLdJJMEeN7W7Ili
 BgyHCsTthphDAtoAZHQsokpRC7QAo1Ii4cqjGdLXGgzOFsKxAiVS/SP17byjXqpJXFfG
 lfV394woRYC99y7PHxBn/t83uDR7cHhvj4rUdMCwPTgy2Hgd6udF2TKe9Nd+QmiIg65k
 mhhRyM7Ve8ALHzdLOU9AyRuNBjougHhB2SHn+eXqzH1YnWeO4fUMKb5gMPk/tzTomabW
 AvrXCPjcyGm32CLklRGHi+5wOzL9NDmypgYBt9WKTbBrqMRvvdZBSu+dCezge4n7QdSX
 XjEg==
X-Gm-Message-State: AOJu0YzJ6Acudb+yaLQoApdHBN9F2cM2O8pocx4NwKnKVej3yKuHqWZK
 Y16gyzM/HlxVdI6Al1Q1xNZHizMYG3JUpZBEEQjrSO2N+Eyd4qyrFlTlaoEOlH6zMdw=
X-Gm-Gg: AZuq6aKjYL3p4UaaV7PmtznEeB9B3cZ3oMhWtSJDj30DPPLs6bv4GAZqGlw4e2tfXJk
 MKbxPlp9rI29ptewkweS2QXMzrdE/veFAEMGbWzkOOtpYhguwzN/Oe2QZBm26Hd662yys4bAV8v
 86W+srwA2Rh7jtbruXoEeQFIz7rEej7I9mz7CiU73MRTJjaXF/9V6uPUguQS5pLoK9Z/k0POqrK
 Ld5MVNQzUQDV1H0afBL6zBhRy+59Kqs9/s2Ux42pDiraTY1LUYoiEVgY2B5C7ChS7paraQ0Kp7f
 r25B+Ir7gK822I/A5AJNKRmyBU8lRpAz7K5v0Jg1zMQvHxfBGMtkFWOfO5p8xG29pdcWVp9WvfZ
 8AN/5Cd7W+vy6XVYOVg6qNVsFfLCMvtBSLdcq4xyRXHRVs2+qtMtxQguFveoaw5svWVz75ZOVcU
 NJts7GnTTlathWKmhxzGW6sZHgPVrKQqDdRN1P1Dvs+1pCpkl1v6HEhRlEaFQyxWVwTYEn5fZc4
 ts=
X-Received: by 2002:a05:600c:4688:b0:483:703e:4ad5 with SMTP id
 5b1f17b1804b1-48373a37af9mr42303435e9.22.1771008474727; 
 Fri, 13 Feb 2026 10:47:54 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a409a5sm20850275e9.26.2026.02.13.10.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 10:47:53 -0800 (PST)
Date: Fri, 13 Feb 2026 10:47:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Selwin Sebastian <selwin.sebastian@amd.com>, Kishore
 Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Jeroen de Borst <jeroendb@google.com>, Joshua
 Washington <joshwash@google.com>, Rosen Xu <rosen.xu@altera.com>
Subject: Re: [PATCH] drivers: disable comma warnings selectively
Message-ID: <20260213104747.1044bbeb@phoenix.local>
In-Reply-To: <20260213151559.656837-1-bruce.richardson@intel.com>
References: <20260213151559.656837-1-bruce.richardson@intel.com>
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

On Fri, 13 Feb 2026 15:14:00 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Rather than disabling -Wcomma for all drivers, only disable it on a
> case-by-case basis for drivers that need it disabled. Use a variable to
> do so, to avoid issues with compilers like MSVC that don't support the
> -Wno-comma flag.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Marking as deferred until Intel driver fixes hit
