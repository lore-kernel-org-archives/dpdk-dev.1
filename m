Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BBFEEC2A8
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 23:01:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16400402E5;
	Tue, 24 Feb 2026 00:01:22 +0100 (CET)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41]) by mails.dpdk.org (Postfix) with ESMTP id 156834027F
 for <dev@dpdk.org>; Tue, 24 Feb 2026 00:01:19 +0100 (CET)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7d4d8712b40so1809049a34.2
 for <dev@dpdk.org>; Mon, 23 Feb 2026 15:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771887679;
 x=1772492479; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhCfJGuduja5ERt/NHEuaPpv4E6vPD5V/xxEPounkqY=;
 b=zbqve4lOSrY+XixmHaEM52pwprtZtgEj/7XvAbZQK920J7bGq9qOoFSsl+obl71tdT
 eJ14DvitocIr4lref9HVv5F9t1RwqFnXP9/736jAC7v3XPBxOV4MStvsDQNL3l2rI8Wt
 Vze3cTggGiS4i3DN/5bPxzd5y5F+8jWoQpy7SsOJ/IFEY+RgoOZGXK/ATvUtukL0MZQS
 DQcL8RwhmwqzkZKkz9+UcB0tpC5nejdmIP8E3fpkX8wTMMEVLaNKzkMbUEsQnlGbM+ze
 m/vmoyRpDimE2VM07yk5sJUPLwU0oe7PN+Khm+5o3ClbNuXzuEH7tCxE7M6SMBqjJ4nM
 rVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771887679; x=1772492479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NhCfJGuduja5ERt/NHEuaPpv4E6vPD5V/xxEPounkqY=;
 b=ZPDDUWoApQX0O2epVWbVIFxxtlzvWtdoqNB4vKr74xmJ9PGTdMoCs+duTMjtDi9JbB
 7hStAK+8kJvItNUp4Rrb9BmmmL3KD+1rNjmHwH+iSKIaIXlgvA71dyAlF0lWdZ47MwN8
 Dyqpw/RIr4Kq1yphEWJ0Ci8TyZT0snEzXdamdUjAyRKIyeylPZWC5/6VES2jkGXMVh9Z
 Glwyum2PzQUyPDbuLtx27qyux5wPSQ6iwvxr+6Y300sVf3MKvvhuRj8BYvE+krvtB1a6
 jd+xQfYL3FlF+cO63Ks0wPrqGMblNekINhtrD71LpE+9JxtFb8HBhf5FIVSR8twNKu+E
 7ZvA==
X-Gm-Message-State: AOJu0Yw8ihDqxXYLcg4uMwK4BlcXm9UJeW3f1HcGlk6JIl7t+8llXdns
 zcDElVEfVbTb836+YQ8eKFdUlNPJqLa65OlDuOuYHcACopLJGJwrkVrc/cSC+Ugf3BE=
X-Gm-Gg: AZuq6aKmH3OEpI046Bjg31CwxF6eEspox70NI4UxlAhbRk113l6yJoTqsNtKPaQ3mXt
 DT5kPAa2eeUeffI9fv+sof1nGH7DkFpB9JyWnKAjtDAsFOLARFDoukatSiVxnOZq2HsoYYcHTOg
 q7VSa3imdeJXOWT1+VyQBfKpXEJ4ZPWEZlWBT2ciZR/LZLDorYlRRRY8YRVYOn6dYNbhAnneS7x
 Oz4lf/umdF35PsO4sSa/NGOk9sU0htzBCsO6hIuHSHN2NC//Sqo9SaZ1Zllmt0AQbX8vCyTGc88
 QuxA7bZu4/IJEaZiCymV4gwQpxiJ5TYeHrdlge9SZND651rqksgJHev9+Ed2TWZw6/ycMH0ErKw
 OmZSx7v7GANo1jILYwa16+ElSemlU6gXKl1Gzl2cphoryX0v3O9LmZFFIQIIKTmxDmqLY8PEedZ
 EcITZR9703fS95Eow9WMjmzBFUe+uh4Qhk8wAscr3rZsklnRA9pUvR+EVjmMoSTna+
X-Received: by 2002:a05:6830:6a85:b0:7c5:3c7d:7e65 with SMTP id
 46e09a7af769-7d52bedcb9cmr7552072a34.16.1771887678906; 
 Mon, 23 Feb 2026 15:01:18 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf9f663sm7867167a34.11.2026.02.23.15.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 15:01:18 -0800 (PST)
Date: Mon, 23 Feb 2026 15:01:15 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Matan Azrad <matan@nvidia.com>
Subject: Re: [EXTERNAL] Re: [RFC] net/vdev_netvsc: check for NetVSC device
 before auto-probe
Message-ID: <20260223150115.3b0c6aa6@phoenix.local>
In-Reply-To: <DS3PR21MB5735AEF2A98A5E9D57F508D8CE77A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260222204813.773962-1-stephen@networkplumber.org>
 <20260222140034.3675188e@phoenix.local>
 <DS3PR21MB5735AEF2A98A5E9D57F508D8CE77A@DS3PR21MB5735.namprd21.prod.outlook.com>
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

On Mon, 23 Feb 2026 21:42:45 +0000
Long Li <longli@microsoft.com> wrote:

> > 
> > This is not sufficient to fix the github problem.
> > The container still has an interface, and cloud-init has given it an address. But it
> > has no route to outside (in container).
> > 
> > It looks like the whole automagic vdev_netvsc model is so brittle it should be
> > removed.  
> 
> Can we set up a default config of not auto probing net_vdev_netvsc? Or some kind of flags that says a driver should not be auto loaded.
> 
> Most customers are running "vdev" arguments to load them in their DPDK application.


The problem is it runs in an initializer so it would have to be a build flag
rather than a runtime flag.
