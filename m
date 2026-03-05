Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4872AF47CA3
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:57:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 963AE402CC;
	Thu,  5 Mar 2026 18:57:12 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id EB3CB4029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:57:11 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8c9f6b78ca4so1087597385a.0
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772733431;
 x=1773338231; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URw9XSheYuUhteQI5Rsim5Uw1A4zudl7EUVEtf9Lw2E=;
 b=bvz6K47f10pydkcTlcMusu1OEczeU7Uv3dlcrAoHYH0E9qUquqlfGOfCugvMByLUuS
 X7keBIbl5agpyQSGbXQBxNkndreRj0AitXN9+dQfrGLmC855T+axfV2dE9ekiusFc2hz
 Fr1ARM+uZMw0f5wvIwemwnCMFgohzWr7uIv7f37UskuFWzngvnrUueyD1ImgGLMFrr8M
 hUqzt7nxuBfFaMD8t+H3IHd/XFoV7pILRKjV7SjWkt91ffhe2YU0DQ9/YuuPAnrbZt0c
 gR7rB6u8OIl/6ABaQogwUtE7j2p/nGSEgMmQ6Kd7WmVX/z0IE0GPK3rh3hu76odTJV2U
 1ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733431; x=1773338231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=URw9XSheYuUhteQI5Rsim5Uw1A4zudl7EUVEtf9Lw2E=;
 b=N43mlCSGgw9V0k2/zsKb7m+WUw3BQxXA+E1LwGG7PV5LLjSZtDkhPI4s3xWk8FaZ79
 XxoBZnFIFhMhtXciE82DuUeyvdd9eg89F+YxDWpAmqkLMwFxQZ3H6uKm2S9ZlJnQXBTe
 nGzL36LDOEcLVpN7hDLINeuTmOzqj+zjniJPSBN5YhGaoB9gLm+TI4QZz7SPlXQgMB6F
 wlzAoM33g6U6hn9Y4bfR184sn8pcHATjV5tMUqosXyKcpt7cP1dNI+hnh+ZgzQtyG8YB
 CWi7qon6RQZj125o6ioeKnbhvtbydJuEoxk6/QIWCeh5KKudOWApdIMnSImnUb9Kv0t6
 eGpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHMOChHIN1JMdsxjlxcvmz8rLe8djPHaVNOsnOIlVk+t4ks0w1g9u2cdcDzgjmb5WHf9o=@dpdk.org
X-Gm-Message-State: AOJu0YyJHZZmVWmQOOUg0yu0LXZnIC7k65ObIA79HQE5RwQSePCZpmgL
 f4HRWbbTO93A4Dlai9eMVMD35FvvedWFfjb5Khg25gP2Kmw3vO7rckhnBFnCX8q5rsM=
X-Gm-Gg: ATEYQzxPiTSXcVEnMn3A7l4RXSFs3OfJy02GtQkC06JF+TEf4f6ZMY/CFOoFXUpoME7
 ZguPNY2MDF4Vt2q/U4PTX3v+lqDyBi3PPg6K2J5vVdB5a4K/xOAptfJ3qL3zAHdm5XZ5DpM1WW9
 LZwLC4R0MgmFkp5nA3TVpL/pefBfV2Ad0ivZxJ4BRnXwXKYgLeobdMEEG0zkUN9Z6My6C113b1r
 yCBY2DDpe4v9hQg2zW/0M0cnEeLP3PNhmmed48IHDVa/Vkl4K+Y2qAlnMe9QGGRxPp85q1eEYIg
 P+W8OLQ7wMDHeS/ikBYfdiqJm0OCCwU77QLDlJpgJ7bZp/l8rvl0CClZgjZK43TWwgkr1nLGkBe
 aIe0w+eRjiQ/pwKbRAQiashtktEq3cAdO/OGbOq5u2KOuXMVuWdjbyL9EBSchmZsvtPKbVocddr
 891QUPUW6Epdf77SEQx7MEjYb8geQAOi7bV+xJ3AVt0n/Zqvh8YGAZgIHx1R5//BL/
X-Received: by 2002:a05:620a:4450:b0:8bb:1a5b:5a47 with SMTP id
 af79cd13be357-8cd5aed4ab2mr861092585a.17.1772733431236; 
 Thu, 05 Mar 2026 09:57:11 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6534f3sm1898357785a.5.2026.03.05.09.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:57:11 -0800 (PST)
Date: Thu, 5 Mar 2026 09:57:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: Maxime Leroy <maxime@leroys.fr>, hemant.agrawal@nxp.com, dev@dpdk.org
Subject: Re: [PATCH v2 00/17] net/dpaa2: fixes and improvements
Message-ID: <20260305095707.03ced639@phoenix.local>
In-Reply-To: <CAJFAV8yFRfHOoBha12Vistp48reyhdgNxaxZpys66eC_MOz5Tw@mail.gmail.com>
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260226143341.282188-1-maxime@leroys.fr>
 <20260226112551.7ec09c50@phoenix.local>
 <CAJFAV8yFRfHOoBha12Vistp48reyhdgNxaxZpys66eC_MOz5Tw@mail.gmail.com>
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

On Thu, 5 Mar 2026 17:55:39 +0100
David Marchand <david.marchand@redhat.com> wrote:

> > Please fix the free bulk bug on Transmit and revise  
> 
> As I replied in other thread, I see no bug on usage of free bulk (not
> the raw helper).

There is no requirement that all packets in one tx burst come from the
same mempool. And free_bulk assumes that all packets in the array
can go back to the mempool of the first element.
