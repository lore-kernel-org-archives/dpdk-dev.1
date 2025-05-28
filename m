Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99461C5AE59
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 20:25:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A63FD40667;
	Wed, 28 May 2025 22:25:41 +0200 (CEST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by mails.dpdk.org (Postfix) with ESMTP id BB3AB40667
 for <dev@dpdk.org>; Wed, 28 May 2025 22:25:39 +0200 (CEST)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-70e302191a3so2578717b3.2
 for <dev@dpdk.org>; Wed, 28 May 2025 13:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748463939; x=1749068739; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7yyeJLZ2FpxSZbVwtIRLjVtZlYAUD4jyA+O+WUhHkQg=;
 b=JnnFtB94jO78WQylffJVAQtuZewuLPk3gHI1peJxf87sft+hc11dU5UnuMOraU+RaF
 KqyB2RvVqkfi/8NrdbUYrOz/0riAlf02D6FUAIGJjutA5yjOxjiU8jORbGb7LoxQDIke
 pqDG3E7UiwdYEuJFgAgQObtRbgjU325tjBqqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748463939; x=1749068739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7yyeJLZ2FpxSZbVwtIRLjVtZlYAUD4jyA+O+WUhHkQg=;
 b=ILTGgb5sNmFeJqkWjESoovvaE5HE+NmAJ63kpLp1j9ZVJcIf8pAXN/B29eAHqjdM2V
 12H+jBWgaW7kXDW3JujSnCixiFvv0IyMm9+55lExzMS3w5Lqu+ON9jUPmhlS0ByJ/c9m
 Nrv2QZU+/M9Eke+xWKNasxxWJo2V1T4yO33kGLfM1sAhyewykGxdzO5afYzF0skqSUop
 YETIbvbrkjB0fLkJ+Ua93LuHBAfAksWRuHLFZ8KpW5sKKLKQ36zm2FRvSVi+YVV6dgAG
 SG4xXdUFehUpemxwUIndZ65MShXX8cBOa6GUcZU16HbJrjr/9c/KXF0/NZc7tEVo3KbM
 MLRQ==
X-Gm-Message-State: AOJu0YxQY+Ic2tbDtG+ikF1qJWs5J9mShUGxcBwJHw1I6//5YfiGZnf1
 s8hWN+H8aRmPde41sVyL8yyVOY4C+JvlVvCRPN6Nwh8SxwoHP+k/dorURfzt1gvUW/brRY4sTfe
 xvvQeqegZeGdLicbhS8b9RkTpI5NNZtH3I5M8AreU9g==
X-Gm-Gg: ASbGncusTu0C6luct2+1muy5gjTCpxkCTXENQgN0v2BAIDkNNVcOD+8429InnHCDe+j
 axoMBmS1JfpQp9liTpANwDycSL13dWNY0MgbHKQzKGpjvKp+qgX3ACfY/UA2BYttJmT6Et0zA4k
 ZCsXUmBE+DuNqxpRoEOhPQ+3y8g1PI3YWcKfGqL/PRXUyTMjIGt/JUEDRVv9Luyi19pW2AZ/fEb
 vVmOZEF6QY2cCCV
X-Google-Smtp-Source: AGHT+IE/le1IIOPplv4W1loL1ErpeXWuv3uobJlTXhwGVd3pfseRFWZq9kR3sogaIsvLUYQ8ZRC6TQuePY9fEDr9SvA=
X-Received: by 2002:a05:690c:8c1a:b0:70f:8913:ed66 with SMTP id
 00721157ae682-70f8913eeacmr5655117b3.38.1748463939142; Wed, 28 May 2025
 13:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250415130903.224858-1-thomas.wilks@arm.com>
 <20250415130903.224858-3-thomas.wilks@arm.com>
In-Reply-To: <20250415130903.224858-3-thomas.wilks@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Wed, 28 May 2025 16:25:28 -0400
X-Gm-Features: AX0GCFsjBJxt8QojbnMDbrkR1-fn-_ws-fHLQZ8qX57E--k28kd-Ud2ATw4EjW8
Message-ID: <CABD7UXOWWyp7W6c=ezcAvRU+JTyA9nRB5ZLLFOC0V7YyAwhYvA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dts: use tmp dir and DPDK tree dir
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>
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

Tested-by: Dean Marx <dmarx@iol.unh.edu>
