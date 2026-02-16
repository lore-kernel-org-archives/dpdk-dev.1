Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83B6E7BD83
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 10:17:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8C8140289;
	Mon, 16 Feb 2026 11:17:09 +0100 (CET)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 1F11D40269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 11:17:08 +0100 (CET)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso2666655eec.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 02:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771237026; x=1771841826; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C75/bX4JNfFWEnGhUC+xPAGMzqvNYzAQazHxohYRpIA=;
 b=dc8++1Mp5rbDgXb+6vGBxHUyA9j1thbkA4k6HOjy+qQps2OHM1GiKj9wz83N0W6KgA
 LDwK6tRObTAbjWjfdyfYWsrQpr4kbNjD9AYVfBwF91/oBQE4Z/8tXvPtFzOGz/QBOV3T
 ZO3XqiPkvV2YIVubdBpOIYRk24kEpa194QXg+nqrF2NVs3wR8eS96aRDCFU3pTiCyH34
 uyRrTKaociWRhyys3rhOXPnrPRL+0nPdwLSJfq4iBIRYjOEAe3cxY8b+QdXu+6hJJ1aC
 n1qcyqPPoWIce6Q5z9Kp2MV+/f0eZOlgk8KhE9kWp8AYf7F2I6CjlHA0b9/n4/WAKHAw
 ffog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771237026; x=1771841826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C75/bX4JNfFWEnGhUC+xPAGMzqvNYzAQazHxohYRpIA=;
 b=HiFOAinvVApHRXCj34he645fNJptTUIl/pMVTJb9q8ghvE3nh8saE6D26VXGXTY8v7
 OlKRYLM5AfYmVTHb+7K/BlWqIvk0Mt6CBv9J/gLMycgJnTpP3kw5vYy0NJ4t5ySWz/Uc
 z9EBgDWQb79RLsFP4jqPvSsnXktITlyfZpdHwfgRrrZB6broIhSYiUhoLRku5esyVkG3
 cU22v+W7D2ziChwEsIVqNlolFc36zIpWdqfR+iwitFFFrjRs3qOBSEsJMi7fT2C55vMs
 wjjkkT7iM08WR+SRIRYTDuuXaqtHcIYTqdbRSSveFeKWwBu6OvMOVcOrvs4e4069okmK
 2Wvw==
X-Gm-Message-State: AOJu0YyNl8jDLNE4bUDqUCgbTkOC3g6Fa3uuaA5vsn/1VkBMYrH8tNDi
 T2z03gqxOjKFhGXX3i26/zkecQx4gf9sma+w3C9tXKPjwwCvs7YATpnjN8TZ6Q==
X-Gm-Gg: AZuq6aKlE0OkDHEDSKbrGH0nkp0s+dBw0+BlmL0TQP5SwPcWGAM5LkEPahI8fgDYR79
 uQH5Y4QahCbHP1aFEY8W0XyaAS/N7fYvT7XD4cd+oNiX1meEHacI5S8Mk2PsPBpa3w2BWvI+mNX
 ApMktFK8VTjyyc54IqDPCByeH2ln5Tg32eT40gPYiy5sAI0UOmKp8nItmZji95DLjP4Oc769bvS
 LB3W0Zl7JABR8LIJIJlaTrRHCqkNBS+vnpV6SOUK9IxyTvj+O6bQtRSXlOMuYYoEusL2HnU0GHV
 QkrQwXYLXvrSaHBjmsO43K3mu78t6bOjsreqr+XZze+RV65VZH9ut511oCtNlOgC2W73s6ldHgZ
 jzVFJBMwfzAH8Fw62YwE/1c5g8hBPTqJ6NpUyIbMvulLpDKIgHJA2OeE/PGitM57WJxCFwrlAAw
 PM3OxCaQGLMpUT8d4c4iwzwEy9WN3OIEnHkaH+5EtC2oeEFHCPUuHiNMPRTimnSQ97b0cmoimw
X-Received: by 2002:a05:7300:6da1:b0:2ba:7b63:3f6e with SMTP id
 5a478bee46e88-2babc3c9740mr2580248eec.11.1771237026491; 
 Mon, 16 Feb 2026 02:17:06 -0800 (PST)
Received: from C9HFQX6C61.corp.nandps.com ([130.41.236.144])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bacb5622f2sm10450311eec.10.2026.02.16.02.17.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 02:17:06 -0800 (PST)
From: Yehor Malikov <malikovyehor@gmail.com>
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, chenbox@nvidia.com, stephen@networkplumber.org
Subject: Re: [PATCH v9] vhost: fix use-after-free in fdset during shutdown
Date: Mon, 16 Feb 2026 11:17:01 +0100
Message-ID: <20260216101701.29340-1-malikovyehor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205183529.66909-1-malikovyehor@gmail.com>
References: <20260205183529.66909-1-malikovyehor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi everyone,

Just a friendly ping on this patch. Let me know if there is any feedback or if anything else is needed from my side!

Thanks,
Yehor
