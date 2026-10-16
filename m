Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E7FCCF2C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 18:19:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E38DE402E9;
	Fri, 16 Oct 2026 20:19:03 +0200 (CEST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46]) by mails.dpdk.org (Postfix) with ESMTP id C018C40291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 20:19:02 +0200 (CEST)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c38ac26cc5dso26762166b.2
 for <dev@dpdk.org>; Fri, 16 Oct 2026 11:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792174742; cv=none;
 d=google.com; s=arc-20260327;
 b=YdT3q9z8Onb8FUVHOnrr2gzOIp2BJmz6UFKQsvxqzENRxKA6kjDI4ApYLZdQrdwNET
 FbTLICE5aYCj7vR42piZcy3k/3OknwAKxb1HTzPsKIpgMICGH1F43NAEPZXleCKLE+VC
 mYK+lNVPgDoT436LbX7Wn0u+MDJmWJjbo3gHfRKbWqRsWJRPpVzU11EgZ3z/xgr1l2BY
 lutTdWYK6qOQYMTVooXj85MLhTHpGNQ91HtSl8rmzJX0lAip/2p1n2PInJDAuQSiCgJ2
 LA7BC1ohgbFuFzZQhIBq+vdegAC9nWYDn05puhI6qV3aWSicPZuEGY7M0SNbceiJMriX
 ieYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tGH0qXGRkt4aQHnAX1BQ/yn+QAvpSqQvohsrsPLGjos=;
 fh=M4Oy3W3WhulLz/Ym4t/nhHML/aooaqzkmcL98BVhqhI=;
 b=NXcT/s5nrDHM/vvIM1723BhChQ9jWUJWzTmQKjlPJ3j/lF64OjXLtIoDlaz0kfDOcq
 hF1T/dzuZzD/bRzzn+L+DyxerajFP7uI6btgxF8zZQ8IZA1OCDCVfDZwoLMoTW0XsusI
 5En796ErofZQJyYJGFZSgul97Abb2tcIf42aIoA0A38ERgTlH4xMb4Siqxd8lDuuYBcQ
 N44JD4dqPLGXd/MJ/j4c/S8EhRJgPxIWqdO9GnKKJI8oxFlw9N5ylLiaslx6RbKMTTFc
 bwxiNFsO3SjQ5MJsb1NSsl/cDuS5TGLEQB40XIDR2UIynjnkcMAKy1yH3wXVOV6DZXLE
 7sTg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792174742; x=1792779542; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tGH0qXGRkt4aQHnAX1BQ/yn+QAvpSqQvohsrsPLGjos=;
 b=hiDgSzzTa4kt6ammkS9roHFGKNxpOZnqQX/0710yRf0gnNiXU5yvmgsgBEkSkwcEuX
 uvWWVGhhYQIOGiy66uNHvXKTx3sB15g1Zp4klYSsuU/AEo0mbMR5oFW3p9KNhKXJBeJc
 aF1h7cSnqi4QANEorh1ABJj8cfed1QZ7zSPZmzfyawaG20tVj++2qdjBoVF3Fi+ve2/I
 Tai1VRpVQxl2SDCk+mHkY2WjWXsenJOhW7BgvS5S2pVuiva5IHctNuCB8SdugeopBzTw
 Ztmauj+KqEkWlHFY1Av4/Jw0rZJrdbvboFgF6cGLmfL3IKiRVmPMJ3fM6Zjchmz1F4iB
 0fjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174742; x=1792779542;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tGH0qXGRkt4aQHnAX1BQ/yn+QAvpSqQvohsrsPLGjos=;
 b=Nao1TAJslV0FPIMx7mTU2lExbb4q5hXzf5+4rx7NpP7yEehBngc47bjrgCLdBx/Dap
 y8WeiizHR/NgfksRhK4caxcFgnObnaG8wC3MO3UrJpOQVPkzAPzyNiyZofsQrHemNci3
 lCfnatJzz8suEexfuohcscD2gQRH4uDL/o7ucyI5e7MuvDT/S8gjaip7a8HMSNNQzOMi
 svivAqrwSYSaN0m0UJIXfo/XwhTkc2DRFN176puqA08CfTKiLsNtKDT7yYxleWc5Rwnf
 1UqTsY/sFzDz97Bn7Pzjr6+xriI5UQ9a4bfOadvyLDStMRne2+JowzI2AwW17YLFwz4d
 plTA==
X-Gm-Message-State: AFq9FYL8GajS8ibuDEg0NBcmRj+jkxRKIsD/TsWy28QuXScBNKkfqB4H
 wFd1m0a3iVJ/CkTw6KQXuQBFClPWsCyNBtIn6Uvm/xFgvQozIQuLZLbNMIz+FwJvvb8wc1DDfsa
 WOGp7MG+p2zapIYg2UljY3YARMt554JxPTljDGuQN
X-Gm-Gg: AYBFou0gFpgTAMinaoWgEgv0dD4H1o80lkvPvvdU/Gt6D83fg+CvdUwTbUu/Z02XunL
 6AndmwLzyWFwK+VQqN5Yi66SFXa9b6T+L+yaqU6ey40XaEu4zSxtNZwzo1vYotEcDFzwjaPUvG+
 SUcPVrBBbAIgIOijpWHQOBALObHNPVzZ/gvE+H3Yc7KOWcEsCcltPeUDRGHhqnTdtaDTj4e07NQ
 Io+1dwUATl9Sj5iTy5dWSemVladd9+86XcmFIREGZ2hEOQ84or019sHwA9Bs36qyzVGzZwfmhVo
 W2fpNK3bfDKJDy41estvbUuMv8tzsh+0SivNi4sNvbXb+qK2pMP8bAr5EnPBUaapmaoB
X-Received: by 2002:a17:907:d19:b0:c41:5970:2360 with SMTP id
 a640c23a62f3a-c419fbfd695mr49690166b.41.1792174741672; Fri, 16 Oct 2026
 11:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
 <0a5ec0b0bcfe33414bb5020959ec8c16c572cef1.1792170902.git.tathagat.dpdk@gmail.com>
In-Reply-To: <0a5ec0b0bcfe33414bb5020959ec8c16c572cef1.1792170902.git.tathagat.dpdk@gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 16 Oct 2026 11:18:49 -0700
X-Gm-Features: AclHuK8TF3bLTHFbKCElKQZw7gRRP2XKzgSQ7efo6i5FBbBaiEjR19_FSfv7m9w
Message-ID: <CALuQH+XMpcmYiMuOVoQ7Uctwb56efgQeYbR1qn1Pp=j8znRLrw@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] net/gve: reject Tx packets that cannot fit in
 the ring
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 stable@dpdk.org, 
 Varun Lakkur Ambaji Rao <varun.la@gmail.com>, Rushil Gupta <rushilg@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Oct 16, 2026 at 10:46=E2=80=AFAM Tathagat Priyadarshi
<tathagat.dpdk@gmail.com> wrote:
>
> A TSO packet needing more descriptors than the ring can ever have
> free fails the ring space check on every burst and blocks the queue.
> One slot is always reserved, the cacheline overlap margin must stay
> free, and up to GVE_TX_MIN_RE_INTERVAL - 1 posted descriptors are not
> reclaimed until more are posted.
>
> Drop such packets and count them as too_many_descs.
>
> Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
> Cc: stable@dpdk.org
>
> Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Acked-by: Joshua Washington <joshwash@google.com>
> ---
>  drivers/net/gve/gve_tx_dqo.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
> index 281700b463..46a03d482d 100644
> --- a/drivers/net/gve/gve_tx_dqo.c
> +++ b/drivers/net/gve/gve_tx_dqo.c
> @@ -123,14 +123,30 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, ui=
nt16_t nb_descs) {
>                 gve_tx_clean_dqo(txq);
>  }
>
> +/* Max descriptors a single packet may use. A larger packet can never pa=
ss
> + * gve_can_tx(): one slot is always reserved, the cacheline overlap marg=
in
> + * must stay free, and up to GVE_TX_MIN_RE_INTERVAL - 1 descriptors post=
ed
> + * after the last report_event are not reclaimed until more are posted.
> + */
> +static inline int
> +gve_tx_max_pkt_descs(const struct gve_tx_queue *txq)
> +{
> +       return (int)txq->nb_tx_desc - 1 - GVE_TX_MIN_DESC_PREVENT_CACHE_O=
VERLAP -
> +               (GVE_TX_MIN_RE_INTERVAL - 1);
> +}
> +
>  /* GVE expects at most 10 data descriptors per mtu-sized segment. Beyond=
 this,
>   * the hardware will assume the driver is malicious and stop transmittin=
g
>   * packets altogether. Validate that a packet can be sent to avoid sendi=
ng
>   * posting descriptors for an invalid packet.
>   */
>  static inline bool
> -gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool i=
s_tso)
> +gve_tx_validate_descs(const struct gve_tx_queue *txq, struct rte_mbuf *t=
x_pkt,
> +                     uint16_t nb_descs, bool is_tso)
>  {
> +       if (nb_descs > gve_tx_max_pkt_descs(txq))
> +               return false;
> +
>         if (!is_tso)
>                 return nb_descs <=3D GVE_TX_MAX_DATA_DESCS;
>
> @@ -294,7 +310,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx=
_pkts, uint16_t nb_pkts)
>                 nb_descs +=3D tso;
>
>                 /* Drop packet if it doesn't adhere to hardware limits. *=
/
> -               if (!gve_tx_validate_descs(tx_pkt, nb_descs, tso)) {
> +               if (!gve_tx_validate_descs(txq, tx_pkt, nb_descs, tso)) {
>                         txq->stats.too_many_descs++;
>                         rte_pktmbuf_free(tx_pkt);
>                         continue;
> --
> 2.43.0
>
