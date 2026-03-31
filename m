Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE8810F9303
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 22:51:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6FF640275;
	Wed,  1 Apr 2026 00:51:07 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id ADD6C4026F
 for <dev@dpdk.org>; Wed,  1 Apr 2026 00:51:06 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-35c124d2613so3983619a91.2
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774997466;
 x=1775602266; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kC/rRca3MmDGPHJhVBShqqH4lgLVSscRJ0teFXNtG9M=;
 b=ykfnzmVtFGKABZBTeu+q5UfQA07vDvINxplAi9ZlLjuvrAgyVuGq13/ofeEzTj8X9Y
 tqakRbMMH5FfGoWvIGr0x0/5qeOKjZuImzdg1IK04blYetzgT6rJ/l2QFUEaFJMT/2vQ
 7t9EkeYOa8kEvOTyjqzxc4YdMlQlGm5F9fA1qBsQ46yxJTdKCkBzqRVzloUNqJ3MP52m
 Kw+/9C5UbBvEHgC5z50b4N/oocphQaLoGOs8QN0gbB7x7OdJ0VbPsp7fVSfE7z34ZQME
 nPgLOkdTM3ra5AssguSjw4TyWaGSum0Nj1Z/3hfsBp2ajq2/O1A3OTSSxFCz2QNiJOyc
 jRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774997466; x=1775602266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kC/rRca3MmDGPHJhVBShqqH4lgLVSscRJ0teFXNtG9M=;
 b=XwToNqg73UhFXJ5q84cXrpMaGwmUbtIcN+64Bpy5ujm7dGbPZHCXPnVrruuj65BSkp
 pcpS2jy/PuYPDn32pn9KDe6NHyd+Admh4vTw7GrxiljryCF1gLAiJfSclikhf/lWmlN9
 CaFxgyNd+gFKOm4GgH7rELHH8SYHVSAQajC1l9xKMYgGzqm04KV5Fk0xc2NpRaPd+DCq
 4iC4X9Fa5lX7cYtUeZsK9dbNnFAaMHbmjTqxTbcpqBiG36d39Or+qu7JYYoW8sL8HTIH
 UZIpyucE1aKOijmD5HVpfZe+3rNohYSEFSpeSdG4a0Fn+fZw1M1iqNEVxZsrIpSQnqQM
 TnUQ==
X-Gm-Message-State: AOJu0YxrQaW4gBv5BCwPHYrK9Fd6a/oYbunFRJTJNjLj2aaXyc5PYUeL
 IyO3y11NPMMFhG398g8HgT74o1OF0EjFtI7EMtFyWN3F1rSeux+eo32QoOclmZ8vCPA=
X-Gm-Gg: ATEYQzyOg9COVxP+iRrF7Wnqe2jOSGos0OY0FbQoG1FM71q4a23H2O7zroa26nfW8GH
 qis3loYqY0/9D6veCxj4IAELVDhm3eZ3vP8bZq5K/iqz85dCkoYG8+o0bAkOUTR+FguhH3xW3QN
 fREE7gy5srQTUX9MvlIat//qaiFu5/lyHYx36w5uzhdyuCL9Gy9SQJR8nSGhWMLcPlmSRkUyi8R
 XwSFyBDLzg5PT7tpfNYQBIxoUXfQHIZu4XamRTyGYkJGrw953FyaB0AQqEfwu2+yfcG5c2zic0u
 kXYJaL6Tpm1zCHo5UaXNFqb4VRcxO003FzjUtbuPGBcvrxiWsrdeVWX08Y0Vgy/K/6aKJD3Hzy/
 wf62r6zAiRrEmi88ecVl8vMvBpOCIXGxm9dQL5vQr6gsBMf3pPEjfoWzPe/wQZOYKR6FjtMtCPY
 4a8CFYNkQjPlH6f8HX7XFz469hbN9dxkH6JeU=
X-Received: by 2002:a17:90b:164b:b0:359:f6f8:57b8 with SMTP id
 98e67ed59e1d1-35dc6e4364fmr908200a91.1.1774997465738; 
 Tue, 31 Mar 2026 15:51:05 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbb840a36sm1397257a91.4.2026.03.31.15.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 15:51:05 -0700 (PDT)
Date: Tue, 31 Mar 2026 15:50:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 4/9] doc: reword service cores section in prog guide
Message-ID: <20260331155058.131b8ac8@phoenix.local>
In-Reply-To: <20240621023254.4258-4-nandinipersad361@gmail.com>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20240621023254.4258-1-nandinipersad361@gmail.com>
 <20240621023254.4258-4-nandinipersad361@gmail.com>
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

On Thu, 20 Jun 2024 19:32:49 -0700
Nandini Persad <nandinipersad361@gmail.com> wrote:

> I've made minor syntax changes to section 8 of programmer's guide, service cores.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> ---

Integrated into other patch https://patchwork.dpdk.org/project/dpdk/patch/20260118191323.241013-3-stephen@networkplumber.org/
