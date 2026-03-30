Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F251061B12
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 16:08:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3B7840616;
	Mon, 30 Mar 2026 18:08:56 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 632C7402D8
 for <dev@dpdk.org>; Mon, 30 Mar 2026 18:08:56 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2c175635a33so3396633eec.0
 for <dev@dpdk.org>; Mon, 30 Mar 2026 09:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774886935;
 x=1775491735; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVGfddFddaR8HsacZDAKuwEM5C0vk1+2ygmehAUeYRA=;
 b=PBGe7wm3upRheLhCxBk5cgbysjSP8B8YtekcSn+4OWQbbRIOUJFBL5arg1jdW2Umub
 S5ArlLaDpivNjgKkIms0Ent8Il9njYhrgkCUR4x4ko9Y26csRXyVgRQdqCzSX9WcCkq4
 vjr8nXE7NVGPReGtiU/CDDrDzz7fBgnYIwVVYeULhW6RRQ2NME9doTxSuIfJMKIR4nzN
 tN/P5kKxDU+IZ9blRAKLYPZ/zBVdv7BEDII7boMMM0iMctfw5JLdDOrGsvL8ciqVlhii
 i/fghQUSI2kFCSgTrW8CNQeUuy6s0ORZIGk3yngH/8Vc4dhcMd5QeaVA5E3XyyYp/jvi
 cEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774886935; x=1775491735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DVGfddFddaR8HsacZDAKuwEM5C0vk1+2ygmehAUeYRA=;
 b=tNfijatV/mmQTKsaKTvZxDvyoRPNnKXil0aJeTg/WUuzAjy4oPE3meFEWa0tSsln/0
 TEgj8WXp1dnYtLRO3WUMN6lCjwIOXajyQOgKD29yCRrNEVOcWJEOZNzl1EKRM55DNGuL
 ANgJV31lFPvYmH1VC89ntVufObt1Kc5tXeqO90KHvDdGnJkz0BF5if+Tz6/2Ksajpopy
 /Vd8SvdyZ3QuD4708t5vgZauIJh+2Gfxfr+x20T/Bkay8UXy9nGPW0o3ifOwm34FdU1Z
 U5HoxF01Ut4cy1G2A8Eyz47YKsqHJjjkgvSmnl4Ii8br/OstrfyWS4gumPckV3E+8LEz
 PdtA==
X-Gm-Message-State: AOJu0YzrFReXbDbIbd56L9Aqt6nNBJS1GkHr//KNVjUFRCBYGz7ZNE/K
 RKnikKCr4iRilCSnoTHog+wPNSZv29y/L7/Ya+nQo9zWJvXjZrk14txQnl8xM+fweDg=
X-Gm-Gg: ATEYQzyzv8W2AMCWfdo+P06QpwHBEq3koQKkXaQ1CHM7N3H9rS/4ogxje1CgvMeGAIY
 x9OV0R5N0T8uVoHYnsogbFhu6wNxBd2JO0TZmG7dsDGX6SGW4v15lzN5MfWqHKjYwU1lPKB2HU0
 cN2cTlo4x3E73V6rQ4p6ErFltBwWgvfmqmZQ2IrJJiN970ycbIoXF57wUz38VFMqwYb6aEKN+Hh
 NaECmMRvwRyBqnekuABgBIpp9zMvCEjBGPGWb5qtohMEa9o71VePX5dqZdnj5dNWDFIU7zHxOHB
 484P2/93u7+8zU27sQ78+mKI8R3cYXNkClnPCDQuNNhu0m4ivQmYEOMRjsc1YLHxxraNzqCgtbe
 sg5yy/hZzfZ13p9GmbzGkWIRgIh3NfyiIWo3MbYJL9rFJzGLTJwiKUc14lj84WaRMvy6wf0lg5B
 pO8NWG/GLGS6xaEj5i91wOrPniUd/KGc1bh1k=
X-Received: by 2002:a05:693c:2b0e:b0:2c1:4f1:c87b with SMTP id
 5a478bee46e88-2c185ed6d8bmr7242015eec.18.1774886934691; 
 Mon, 30 Mar 2026 09:08:54 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9f4dsm7448737eec.2.2026.03.30.09.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 09:08:54 -0700 (PDT)
Date: Mon, 30 Mar 2026 09:08:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 2/9] doc: reword argparse section in prog guide
Message-ID: <20260330090851.5cbd10ee@phoenix.local>
In-Reply-To: <20240621023254.4258-2-nandinipersad361@gmail.com>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20240621023254.4258-1-nandinipersad361@gmail.com>
 <20240621023254.4258-2-nandinipersad361@gmail.com>
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

On Thu, 20 Jun 2024 19:32:47 -0700
Nandini Persad <nandinipersad361@gmail.com> wrote:

> I have made small edits for syntax in this section.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>

Superseded by https://patchwork.dpdk.org/project/dpdk/patch/20260118191323.241013-2-stephen@networkplumber.org/
