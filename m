Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D4606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IHZ2l/WM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B60440296;
	Thu,  5 Nov 2026 09:32:58 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by mails.dpdk.org (Postfix) with ESMTPS id 04BF640281
 for <dev@dpdk.org>; Thu,  5 Nov 2026 09:32:55 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b4bd3d98bfso1805488a12.1
 for <dev@dpdk.org>; Thu, 05 Nov 2026 00:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793867575;
 x=1794472375; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N3rADq4P8HZk1vlMGIUMHcvXV/RXM0SH1KsRS2c1SuM=;
 b=IHZ2l/WMQufPotcAGgOOdT50Gd2vzm0AxUvBmQvHA3y8BAVyoxairBQB/ixkw4D3RS
 +QvzTsIds1VVUS+CuguHtIVyl8cbeHK3LlIaVKs9GTHyQXQsknTfzlLCAK7ojx2uz4uj
 Bv7guGuPFxC+lvlahWwyAtBJtqy+ALuBmSjQ1HYh37kc41Le0CJO99Mg7V4vtAMzcPHZ
 6xZoYhgFcbJmiggBNPMlwzG9p+cWWUwINHCa4ULz2W2/cgD7YPtWokrOq2oylxHBEsW0
 yUTh/+6D02rVqoV7Bf6utcZHd69dadAI4mzfl1CHJGAYB72EiuG1rw9UQvtiE5FO01gT
 8hhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793867575; x=1794472375;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N3rADq4P8HZk1vlMGIUMHcvXV/RXM0SH1KsRS2c1SuM=;
 b=k6mc2r2DzE9GVzIy3oVMvbSVDo1HceuK2LGcT/6k+o/p/NsRLNYJXsCKXPNAjIRoXM
 FpCJAJvl9x4tC3/s7moES9uwTrTe4yDr1EOxvwZywy4an8Vdq1b+gZDdY5hBkJgzZoL7
 0uOVdj55jh3VufsF6MUlJqDhmxlKwCHEmxG+zbU1nzWBZV6lIV6pWWNfWT46z8ibZ3C2
 ZBYZLmmDwx6x4a2sDtW9zFWmCCTQtpC+B2D/1R1i2cDEBrE+8zroQgGt5ugty5DWTzHA
 PLecxJ8LXb10fFgvAJKiGLl4YPKSH/GfvDLEo05KFCy6vktGCq7hIWs67GKvd0wWwa2O
 LXEA==
X-Gm-Message-State: APuU4Z+FLKFMGbUD6fd83CFfSQZfEe1NwaJgwSv/MYhAuxAsmKfbhri+
 16JOYeBFg1UGAVkxT2SYcbjraZmGogIb1ovtzxcD+1SQ5lOmNrTAAoF3t+JntcdB7tM=
X-Gm-Gg: AYBFou3m9QbiowE7lSZ1qB6/Iy+jtMRiYvraAPQRxlOOBR1RrE89+0SuAziV1TZ9oOZ
 245hArisIUQb2uRQvuK1UBm7hIF1GFOtFvdyxVVBiRZwHS9ePzSnoPPJ3bTqH3V536+PeiFe19H
 3uKEuyx9gzlBYCN+Gr7g25NNsM4COGEbtLvidxtsd/Tr5N9N5PhX8F3WO2Auo37VDWP5OhWlD3h
 N/2qXTlYiXrmcNm4lVZhr0bqi4dSiyOREJmd0VjAW/79kXA7g50Jnubb3MmIKg3xMS3g9fmtANj
 QYjMJrHZX0iZt6404oMbyKmaL6Bmi4rO9TjkNf5c0iyBJtSb2tDxgGJPuizgxb70IRxE9PkN8hx
 MDM5YbUHPjMZCRY9FvIHH344xRc87UeJGbnlxYgIeAtWe5N7WXs47Hnzdvpx2QCrLfZJciLkDhY
 Njtas6gPbJ2/vtnmkq7/rPrzt4/dlm6wvg8jNl0l7NzsRL/d1hUbnZ0TRCwHqgz1gZxLkVe28rN
 nZJARW448Xa61G6Qc6ByyeLKfdSDKk4vtpVluHa1g4yzZMTcZaQIK4E/5jvkiDEG4w2zMugOP4f
 1kIym7SYYU0a6CZIBmEX2zS5qV34eItJoufrRHH/Lod2D0ul9oWGlFMsptpelNIePmXkLEIIhvA
 b8cvaQ1eMUAgHO6hA
X-Received: by 2002:a05:6402:13cb:b0:6b3:f692:985c with SMTP id
 4fb4d7f45d1cf-6b515507eaamr9721087a12.44.1793867575374; 
 Thu, 05 Nov 2026 00:32:55 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b57e26b0ffsm445943a12.32.2026.11.05.00.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:32:54 -0800 (PST)
Date: Thu, 5 Nov 2026 09:32:52 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, sriram.yagnaraman@ericsson.com, jgrajcia@cisco.com,
 thomas@monjalon.net
Subject: Re: [PATCH] net/memif: fix use after free on listener socket close
Message-ID: <20261105093252.59fcdf28@stephen-xps.local>
In-Reply-To: <20261104164153.1674329-1-david.marchand@redhat.com>
References: <20261104164153.1674329-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed,  4 Nov 2026 17:41:53 +0100
David Marchand <david.marchand@redhat.com> wrote:

> memif_socket_remove_device() calls rte_intr_callback_unregister() on
> the listener socket interrupt handle. If memif_listener_handler() is
> active at that point, the unregister returns -EAGAIN and the code
> proceeds to close and free the handle while the handler is still
> running.
> 
> Use rte_intr_callback_unregister_sync() which retries until the
> handler completes.
> 
> Fixes: 7281511c2cfa ("net/memif: fix some interrupt FD leaks")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Manually run AI review likes the patch but sees related pre-existing problem

Subject: Re: [PATCH] net/memif: fix use after free on listener socket close

On Wed,  4 Nov 2026 17:41:53 +0100
David Marchand <david.marchand@redhat.com> wrote:

> memif_socket_remove_device() calls rte_intr_callback_unregister() on
> the listener socket interrupt handle. If memif_listener_handler() is
> active at that point, the unregister returns -EAGAIN and the code
> proceeds to close and free the handle while the handler is still
> running.

The fix is correct. memif_socket_remove_device() is only reached from
memif_dev_close() in the primary, never from an interrupt callback,
so the _sync variant cannot spin on its own callback.

Info:

The same pattern is left in memif_socket_create_or_reuse(), on the
rte_hash_add_key_data() failure path. The listener callback was just
registered, so a client connecting in that window hits the same race.
Worth converting in the same patch:

	if (socket->listener) {
-		rte_intr_callback_unregister(socket->intr_handle,
-			memif_listener_handler, socket);
+		rte_intr_callback_unregister_sync(socket->intr_handle,
+			memif_listener_handler, socket);
		rte_intr_fd_close(socket->intr_handle);

Separate, pre-existing issue (not for this patch): control channels
accepted by memif_listener_handler() hold cc->socket but are not
tracked by the socket until memif_msg_receive_init() binds them to a
device. If the last device is closed while a client is between accept
and INIT, the socket is freed and the later INIT walks
cc->socket->dev_queue on freed memory. memif_socket_remove_device()
needs to disconnect pending control channels (or the socket needs a
list of them) before rte_free(socket).

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
