Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B79ECD983
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 16:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECDE24275A;
	Thu,  5 Feb 2026 17:48:03 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 886CC402E6
 for <dev@dpdk.org>; Thu,  5 Feb 2026 17:48:01 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-43626796202so572820f8f.3
 for <dev@dpdk.org>; Thu, 05 Feb 2026 08:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770310081;
 x=1770914881; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0nHc6lbcpzXnCNmV6q6C4I1NIOaMvA5rEx9n26gCB0=;
 b=tapmOBpKxVZ/fYLI/+gqZ5YRi+SiIg6Wex5XwawdonjUZz1uN/LxpHzudbwoRA5gI3
 uWPdVn10Jyx/WnyK0tQI6dhQsD5Rnz9fEuy+hr2eV9oEyEc8IAi8QCFmpNW9brWoi3r1
 ++vPzXL6f4lz82vc6rmGeWXpz3O+wrtZucIdXSc7Hh3GoVbCUBNE00MEyqqvufMB8vx4
 +U/GlZPSbTgWRmceLtSgxur7FE+pFguV+Gmkr79E3QDbJ2CfzErOmCIxdkHQlfETGTSh
 WFrhzv2MMp47QP0cUaa1CzsCEo6zZ5q2pfe2l3d4BtUwkJPlcx1KrZC33KZPAf1VaG9G
 +OyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770310081; x=1770914881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+0nHc6lbcpzXnCNmV6q6C4I1NIOaMvA5rEx9n26gCB0=;
 b=cTVmGbnEUsb6sfXLWGYWsPDE45424ZsWqtqdHph0HM++y8o1p6SP3LRi612DidgAIQ
 LNayyKYbSlukPFXFBrmobwEDm8vijTAshB+VxoczV0aFyVkDT8/7doAv7m3MHjgfsL6Q
 Sn9txP5g5h0G1lZsHrKiN5Xwe3VBLCxKfsWYMDgbTBx33DpX7m7mJfctPOr4uWYcvcRS
 S2WmAz4qSAAxstwJu3pJqIJqf2LVeZN/gfENY8BLZ0LJQzegeDq7KnLWCyk+1tiZityB
 xqdASAKryka+W1/fEdelecbpLJd4N8GUjB6dKaJQfaRN2P1bONdfObd0wZ1OEceK0i9M
 rj4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVygqiIhn0iqqzZPWhJydRjcmHZp9UUWIzvDyfwq5aPKvnaIAdwAdlP34edWifL6rYGQ4U=@dpdk.org
X-Gm-Message-State: AOJu0YxeHkFu1mgnpWx9ThVHaJMjurwJvfF3g0vSH2Q+1T05k6kEXV0s
 rb+pyflIdrkJlLEehDB9hPUT1LDNcCsv8UoNrQHIyM/VbW8t7rHttOEWEJFxuHGwxrc=
X-Gm-Gg: AZuq6aK5f/y6UO9lmbhNZ1SBR0BKUhCaFgMQelGzECjC6OImxvRpu+1qr79xtt4zv8p
 pq9y1lMzd75qCIMJE6XpU6M2IcfxdYsXPECASo+HUJPr1BL+WsA2nZb2y4HfF+/YcoUZEhnauec
 4Pfz//QyIHpijX5jPFXdstU9k4Aq+oAUejKt7yvJC+4XprQpRtQ+WjP3XtUZ7NXMXjhTqyvaMbq
 lQ2ZIValfPlFUeduO65DJVjSV9Z7u5zDeeMYg3n1lKoAFlP1CMFc1y4uf1W1t3WYniEXTtlI4tZ
 mfQHJIpQ22jq+qlee6xRIVuTxvk20OaCaR0tvtC7jjMfPXs6PhjCcizDMGo/vT7C8x9FpGR23DF
 pESwQe+xrLzzqfX9Lz0yfyF1Lj33W568wbW5RSKOLAkYp+6FykAD6ZQMN9BJRfNMDxUYNybdb+5
 sfdVqWVCt+I25D3nLAqjskgY8wrqpOmeLm5YBmmuMp2JvB1dHJvTv7
X-Received: by 2002:a05:6000:400e:b0:435:e451:39d4 with SMTP id
 ffacd0b85a97d-4361805bb39mr10502274f8f.44.1770310081093; 
 Thu, 05 Feb 2026 08:48:01 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e3a486sm15354674f8f.16.2026.02.05.08.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 08:48:00 -0800 (PST)
Date: Thu, 5 Feb 2026 08:47:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: NAGENDRA BALAGANI <nagendra.balagani@oracle.com>
Cc: "users@dpdk.org" <users@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, Kapil
 Kumar Jain <kapil.k.jain@oracle.com>
Subject: Re: Clarification on Possible Buffer Overflow Issues Reported by
 Fortify Tool
Message-ID: <20260205084749.7ccb9e0f@phoenix.local>
In-Reply-To: <DM6PR10MB4124DC8DC85BFAE8FB7924D69699A@DM6PR10MB4124.namprd10.prod.outlook.com>
References: <DM6PR10MB41241F954D9C9680F98B29E996EFA@DM6PR10MB4124.namprd10.prod.outlook.com>
 <DM6PR10MB4124DC8DC85BFAE8FB7924D69699A@DM6PR10MB4124.namprd10.prod.outlook.com>
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

On Thu, 5 Feb 2026 06:58:29 +0000
NAGENDRA BALAGANI <nagendra.balagani@oracle.com> wrote:

> Hi Team,
> This is a gentle follow-up on my earlier mail regarding the Fortify static analysis findings in DPDK, for which I had also raised Bug 1748.
> 
> Could you please let us know if there is any update or guidance from the community/maintainers on whether these are known false positives or if they need further investigation.
> 
> Thank you for your time and support.

Did you file bugzilla entries and/or submit patches?
